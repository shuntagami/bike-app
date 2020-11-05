class Bike < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :cc
  belongs_to_active_hash :maker
  belongs_to_active_hash :type


  validates :bike_name, presence: true
  #セレクトボックスの選択が「--」の時は保存できないようにする
  validates :cc_id, :maker_id, :type_id, numericality: { other_than: 0 } 
end
