FactoryBot.define do
  factory :post do
    description {Faker::Lorem.sentence}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.jpg')) }
    association :user
  end
end