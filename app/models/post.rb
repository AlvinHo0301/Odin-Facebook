class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  default_scope {order(created_at: :desc)}

  validates :user_id, presence: true
  validates :tittle, presence: true,

  validates :body, presence: true

end
  