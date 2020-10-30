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
end

# ユーザーAvatar生成
users = User.order(:id).take(10)
users.each_with_index do |user, i|
user.avatar.attach(io: File.open("./db/fixtures/avatar/avatar-#{i + 1}.jpg"), filename: "avatar-#{i + 1}.jpg")
user.save
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..10]
followers = users[6..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }