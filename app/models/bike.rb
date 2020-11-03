class Bike < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :cc
  belongs_to_active_hash :maker
  belongs_to_active_hash :type
end
