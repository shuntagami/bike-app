# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentence }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.jpg')) }
    association :user

    trait :with_comments do
      after(:create) do |post|
        create_list(:comment, 1, post: post)
      end
    end

    trait :with_likes do
      after(:create) do |post, _evaluator|
        create_list(:like, 1, post: post)
      end
    end
  end
end
