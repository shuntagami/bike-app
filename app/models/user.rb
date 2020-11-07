class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_one :bike,    dependent: :destroy
  accepts_nested_attributes_for :bike
  has_many :posts,    dependent: :destroy
  # 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  # 自分がフォローされるユーザーとの関連
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :comments, dependent: :destroy
  # has_one_attached :avatar
  # いいね機能用中間テーブル
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  before_validation { email.downcase! }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { maximum: 255 },
            format: {
              with: VALID_EMAIL_REGEX
            }

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # フォローされているか判定
  def followed_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end

  # お気に入り追加
  def like(post)
    likes.find_or_create_by(post_id: post.id)
  end

  # お気に入り削除
  def unlike(post)
    likes.find_by(post_id: post.id).destroy
  end

  # お気に入り登録判定
  def like?(post)
    like_posts.include?(post)
  end

  # def self.guest
  #   find_or_create_by!(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     user.name = "ゲスト"
  #   end
  # end
end
