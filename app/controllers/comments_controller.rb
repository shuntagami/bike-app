class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to comment.post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
