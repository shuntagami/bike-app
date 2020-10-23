Faker::Config.locale = :ja

# ユーザー作成
99.times do |n|
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

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }