FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentence }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.jpg')) }
    association :user

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
      end
    end
  end
end
