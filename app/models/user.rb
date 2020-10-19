class User < ApplicationRecord
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  # いいね機能用中間テーブル
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
end
