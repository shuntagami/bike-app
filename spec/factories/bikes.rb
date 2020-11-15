# frozen_string_literal: true

FactoryBot.define do
  factory :bike do
    bike_name { 1 }
    cc_id { 1 }
    maker_id { 1 }
    type_id { 1 }
    association :user
  end
end
