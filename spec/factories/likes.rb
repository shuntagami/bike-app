# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :post
    user { post.user }
  end
end
