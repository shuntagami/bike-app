Faker::Config.locale = :ja

# 都道府県マスタ、市区町村マスタの生成
# CSVファイルを使用することを明示
require 'csv'

# 使用するデータ（CSVファイルの列）を指定
CSVROW_PREFID = 1
CSVROW_PREFNAME = 2
CSVROW_CITYNAME = 3

# CSVファイルを読み込み、DB（テーブル）へ保存
CSV.foreach('db/csv/prefectures_cities.csv') do |row|
  prefecture_id = row[CSVROW_PREFID]
  prefecture_name = row[CSVROW_PREFNAME]
  city_name = row[CSVROW_CITYNAME]

  Prefecture.find_or_create_by(name: prefecture_name)
  City.find_or_create_by(name: city_name, prefecture_id: prefecture_id)
end

# ゲストユーザー作成
User.create!(name: 'GuestUser',
             email: 'guest@example.com',
             password: '12345678',
             password_confirmation: '12345678',
             created_at: Time.zone.now,
             updated_at: Time.zone.now,
             guest: true)

# ユーザー作成
10.times do |n|
  name  = "テスト太郎#{n + 1}"
  email = "sample-#{n + 1}@example.com"
  password = 'password'

  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)
end

# ユーザーAvatar生成
users = User.order(:id).take(10)
users.each_with_index do |user, i|
  user.avatar = open("#{Rails.root}/db/fixtures/avatar/avatar-#{i + 1}.jpg")
  user.save
end

# 管理ユーザー作成
User.create!(name: 'Admin User',
             email: 'admin@example.com',
             password: '12345678',
             password_confirmation: '12345678',
             created_at: Time.zone.now,
             updated_at: Time.zone.now,
             admin: true)

# ユーザーのバイク情報作成
CSV.foreach('db/csv/bike.csv') do |row|
  user_id = row[0]
  bike_name = row[1]
  cc_id = row[2]
  maker_id = row[3]
  type_id = row[4]

  Bike.create!(user_id: user_id, bike_name: bike_name, cc_id: cc_id, maker_id: maker_id, type_id: type_id)
end

# Post作成
i = 0
users = User.order(:id).take(7)

users.each do
  1.upto(7) do |j|
    j = ((i * 7) + j)
    # Cityマスタからランダムに1件返す
    cities = City.where('id >= ?', rand(City.first.id..City.last.id)).first
    image = open("#{Rails.root}/db/fixtures/post/post-#{j}.jpeg")
    description = Faker::TvShows::BojackHorseman.quote
    weather = ApplicationHelper::WEATHERS.sample
    feeling = ApplicationHelper::FEELINGS.sample
    road_condition = ApplicationHelper::ROAD_CONDITION.sample
    prefecture_id = cities.prefecture_id
    city_id = cities.id

    users[i].posts.create!(
      image: image,
      description: description,
      weather: weather,
      feeling: feeling,
      road_condition: road_condition,
      prefecture_id: prefecture_id,
      city_id: city_id,
      created_at: i.zero? ? Time.zone.now : rand(Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day)
    )
  end
  i += 1
end

# お気に入りデータ作成
users = User.order(:id).take(8)
posts = Post.order(:id).take(15)
users.each do |user|
  posts.each do |post|
    user.like(post) unless user.id == post.user_id
  end
end

# 投稿の説明、天気、体感、路面状況
CSV.foreach('db/csv/description.csv') do |row|
  post_id = row[0]
  description = row[1]
  weather = row[2]
  feeling = row[3]
  road_condition = row[4]

  Post.where(id: post_id).update(description: description, weather: weather, feeling: feeling, road_condition: road_condition)
end

# コメント
CSV.foreach('db/csv/comment.csv') do |row|
  user_id = row[0]
  post_id = row[1]
  text = row[2]

  Comment.create!(user_id: user_id, post_id: post_id, text: text)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..10]
followers = users[6..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
