class User < ApplicationRecord
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
end
