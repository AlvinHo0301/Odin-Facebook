class PostController < ApplicationController

def index
    if current_user.friends.any?
      friends_ids = ""
      current_user.friends.each do |friend|
        friends_ids += "OR user_id = #{friend.id}"
      end
    end
    @posts = Post.where("user_id = :user_id #{friends_ids}", user_id: current_user.id)
    @posts = @posts.page(params[:page]).per_page(10)
  end

def create
    if params["/post"].nil
      @like = like.new(user_id: params[:user_id], likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
      if @like.save
          flash[:notice] = "Post liked"
          redirect_to request.referrer
      else   
        flash[:alert] = "Unable to like post"
        redirect_to request.referrer
      end
else
      @post = current_user.posts.create(tittle: params["/post"][:tittle], body: params["/post"][:body])
        flash[:notice] = "Post posted"
        redirect_to posts_path
      else
        flash[:alert] = "Couldn't post post"
        redirect_to posts_path
      end
    end
  end


def destroy
  @posts = Post.where(id: param[:id])
    if @post.destroy(params[:id])
      flash[:notice] = "Post deleted"
      redirect_to posts_path
    else
      flash[:notice] = "Post couldn't be deleted"
      redirect_to posts_path
    end
  end
end

  

