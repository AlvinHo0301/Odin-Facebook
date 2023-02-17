class User < ActiveRecord::Base

has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :friend_requests, dependent: :destroy
has_many :pending_friends, through: :friend_request, source: :friend
has_many :friendships, dependent: :destroy
has_many :friends, through: :friendship
 
devise :database_authenticatable, :registerable, 
       :recoverable, :rememberable, :trackable, :validatable

default_scope {order(created_at ;desc)} 

before_save {self.email.downcase!}

validates :name, presence true,
validates :email, format: {with:  }


def remove_friend(friend)
    current_user.friend.destroy(friend)
end

def self.from_omniauth(auth)
  where(provider: auth.provider, uid.auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name
  end
end

def self.new_with_session(params,session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
end

end