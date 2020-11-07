Faker::Config.locale = :ja
# ユーザー作成
10.times do |n|
  name  = "テスト太郎#{n + 1}"
  email = "sample-#{n + 1}@example.com"
  password = "password"

  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)
  Bike.create!(bike_name: "CB400sf",
               cc_id: 1,
               maker_id: 1,
               type_id: 1,
               user_id: n+1,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)
end

# ユーザーAvatar生成
users = User.order(:id).take(10)
users.each_with_index do |user, i|
user.avatar = open("#{Rails.root}/db/fixtures/avatar/avatar-#{i + 1}.jpg")
user.save
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..10]
followers = users[6..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# ゲストユーザー作成
User.create!(name: 'Guest User',
             email: 'guest@example.com',
             password: '12345678',
             password_confirmation: '12345678',
             created_at: Time.zone.now,
             updated_at: Time.zone.now,
             guest: true)
Bike.create!(bike_name: "CB400sf",
               cc_id: 1,
               maker_id: 1,
               type_id: 1,
               user_id: 11,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)

# 管理ユーザー作成
User.create!(name: 'Admin User',
             email: 'admin@example.com',
             password: '12345678',
             password_confirmation: '12345678',
             created_at: Time.zone.now,
             updated_at: Time.zone.now,
             admin: true)
Bike.create!(bike_name: "管理人のバイク",
               cc_id: 1,
               maker_id: 1,
               type_id: 1,
               user_id: 12,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)