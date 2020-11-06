FactoryBot.define do
  factory :post do
    description {Faker::Lorem.sentence}
    association :user
  end
end