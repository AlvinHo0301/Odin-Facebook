class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship
  default_scope{order(creted_at: :desc)}

  belongs_to :user
  belongs_to :friend,class_name: 'User'

      validates :user, presence: true
      validates :friend, presence: true,

      validates :not_self
  

private

def create_inverse_relationship
  friend.friendships.create(friend: user)
end

def destroy_inverse_relationship
  friendship = friend.friendships.find_by(friend: user)
  friendship.destroy if friendship
end

def not_self
  errors.add(:friend, "can't be equal to user") if user == friend  
  end
end

 