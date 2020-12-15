FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    after(:build) do |user|
      user.bike = build(:bike, :user => user)
    end
  end

  trait :invalid do
    name { '' }
    email { 'test@invalid' }
    password { 'foo' }
  end

  trait :admin do
    name { 'AdminUser' }
    email { 'admin@example.com' }
    password { '123456' }
    admin { true }
  end

  trait :guest do
    name { 'GuestUser' }
    email { 'guest@example.com' }
    password { '12345678' }
    guest { true }
  end

  trait :with_posts do
    after(:create) do |user|
      create_list(:post, 1, user: user)
    end
  end

  trait :with_comments do
    after(:create) do |user|
      create_list(:comment, 1, user: user)
    end
  end
end
