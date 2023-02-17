class FriendRequest < ApplicationRecord

    belongs_to :user
    belongs_to :friend, class_name: "User"
    default_scope {order(created_at: :desc)}

    validates :user, presence: true
    validates :friend, presence: true,

    validates :not_self

    private

    def not_self
      errors.add(:friend, "can't be equal to user") if user == friend
    end
  end
  
