class CommentsController < ApplicationController

def create
  if params[:comment][:content] == ""
     @like = Like.new(user_id: params[:user_id], likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
        flash[:notice] = "Comment liked"
        redirect_to request.referrer
  else
        flash[:alert] = "Couldn't make comment"
        redirect_to request.referrer
end
else
    @comment = current_user.comments.create(comment_params)
    if @comment.save
        flash[:notice] = "Comment made"
        redirect_to request.referrer
    else
        flash[:alert] = "Couldn't make comment"
        redirect_to request.referrer
    end
  end
end

private

def comment_params
  params require(:commen).permit(:content, :user_id, :commentable_id, :commentable_type)
end


end