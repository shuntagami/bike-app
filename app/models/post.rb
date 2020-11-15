# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  # いいね機能用中間テーブル
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  # 画像なしの投稿を保存できないようにする
  validates :image, presence: true

  # 説明の文字数制限
  validates :description, length: { maximum: 300 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
