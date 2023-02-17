class FriendsController < ApplicationController

def create 
  @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
  if @friendship.save
      flash[:notice] = "Friendship accepted"
      request = FriendRequest.find_by(user_id: current_user.id, friend_id: params[:friend_id])
      request.destroy
      redirect_to user_path(params[:friend_id])
  else 
     flash[:alert] = "Could not accept request"
     redirect_to root_path
  end
end

def index
    @friends = current_user.friendships.all.page(params[:page]).per_page(10)
end

def destroy
    @friendships = Friendship.find_by(user_id: params[:id])
    if @friendship.destroy
        flash[:notice]  = "Friendship deleted"
        redirect_to users_path
    else
       flash[:notice] = "Unable to destroy friendship"
       redirect_to root_path
    end
  end
end
