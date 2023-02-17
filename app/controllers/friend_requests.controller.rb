class FriendRequestController < ApplicationController

def create
  @friend_request = FriendRequest.create(user_id: params[:user_id], friend_id: current_user.id)
  if @friend_request.save
      flash[:notice] = "Friend request sent"
      redirect_to user_path(params[:user_id])
  else
     flash[:alert] = "Could not send request"
     redirect_to root_path
  end
end

def index
    @friend_request = current_user.friend_request.all

def destroy
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.destroy
        flash[:notice] = " Friend request deleted"
        redirect_to user_path(current_user)
    else
      flash[:alert] = "Could not delete request"
      redirect_to root_path
    end
  end
end