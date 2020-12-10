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

  # 検索機能
  scope :search, lambda { |search_params|
    return if search_params.blank?

    description_like(search_params[:description])
      .prefecture_id_is(search_params[:prefecture_id])
      .city_id_is(search_params[:city_id])
  }
  # descriptionが存在する場合、captionをlike検索する
  scope :description_like, ->(description) { where('description LIKE ?', "%#{description}%") if description.present? }
  # prefecture_idが存在する場合、prefecture_idで検索する
  scope :prefecture_id_is, ->(prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }
  # city_idが存在する場合、city_idで検索する
  scope :city_id_is, ->(city_id) { where(city_id: city_id) if city_id.present? }
end
