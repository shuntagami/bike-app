class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :prefecture
  belongs_to :city
  # いいね機能用中間テーブル
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  # 空の投稿を保存できないようにする
  validates :image, presence: true
  validates :weather, presence: true
  validates :feeling, presence: true
  validates :road_condition, presence: true

  # 説明の文字数制限
  validates :description, length: { maximum: 300 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
