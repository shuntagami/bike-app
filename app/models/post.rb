class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  # いいね機能用中間テーブル
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  # has_one_attached :image

  #画像なしの投稿を保存できないようにする
  # validate  :image_presence

  #説明の文字数制限
  validates :description, length: { maximum: 300 }

  # def image_presence
  #   unless image.attached?
  #     errors.add(:image, "can't be blank" )
  #   end
  # end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
