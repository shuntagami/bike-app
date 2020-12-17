FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentence }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.jpg')) }
    association :user
    prefecture_id { 1 }
    city_id { 1 }
    weather { '晴れ' }
    feeling { 'メッシュジャケットで快適' }
    road_condition { '問題なし' }
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }

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
