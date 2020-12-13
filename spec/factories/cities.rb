FactoryBot.define do
  factory :city do
    association :prefecture
    name { '横須賀市' }
  end
end
