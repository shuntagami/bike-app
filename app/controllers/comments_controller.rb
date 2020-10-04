class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.post
    else
      redirect_to comment.post, flash: {
        notice: comment,
        error_messages: comment.errors.full_messages
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
