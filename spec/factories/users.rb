FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
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
    password { '123456' }
    guest { true }
  end

  trait :with_bike do
    transient do
      bike_count { 1 }
    end

    after(:create) do |user, evaluator|
      create_list(:bike, evaluator.bike_count, user: user)
    end
  end

  trait :with_posts do
    transient do
      posts_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, user: user)
    end
  end

  trait :with_comments do
    transient do
      comments_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:comment, evaluator.comments_count, user: user)
    end
  end
end