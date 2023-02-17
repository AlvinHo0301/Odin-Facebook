class Comment < ApplicationRecord

belongs_to :commentable, polymorphic: true
has_many :comments, as: :commentable
has_many :likes , as: :likeable
default_scope { order(created_at: :asc)}

validates :content, presence: true
validates :user_id, presence: true
validates :content, length: {Maximum: 140}
end