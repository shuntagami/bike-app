FactoryBot.define do
  factory :bike do
    bike_name { 'CB400スーパーフォア' }
    cc_id { 2 } #250cc~400cc(中型)
    maker_id { 1 } #ホンダ
    type_id { 1 } #ネイキッド
    association :user
  end
end
