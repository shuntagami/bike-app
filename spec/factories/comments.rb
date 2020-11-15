# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text { 'コメント' }
    association :post
    user { post.user }
  end
end
