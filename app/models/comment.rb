class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # default_scope -> { order(created_at: :DESC) }
  validates :text, presence: true, length: { maximum: 140 }
end
