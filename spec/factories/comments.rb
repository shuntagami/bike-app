FactoryBot.define do
  factory :comment do
    text { 'コメント' }
    association :post
    user { post.user }
  end
end
