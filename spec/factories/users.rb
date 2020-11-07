FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
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