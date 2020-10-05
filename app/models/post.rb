class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :cc
  belongs_to_active_hash :maker
  belongs_to_active_hash :type
  
  has_one_attached :image

  #空の投稿を保存できないようにする
  validates :name, :description, presence: true
  validate :image_presence

  #説明の文字数制限
  validates :description, length: { maximum: 300 }

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :cc_id, :maker_id, :type_id, numericality: { other_than: 0 } 

  def image_presence
    unless image.attached?
      errors.add(:image, "can't be blank" )
    end
  end
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
