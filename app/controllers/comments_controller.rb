class CommentsController < ApplicationController
  before_action :redirect_to_root

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.post
      # ActionCable.server.broadcast 'post_channel',
      #                              comment: comment, user: comment.user, time: I18n.l(comment.created_at), post: post
    else
      redirect_to comment.post, flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:success] = 'コメントが削除されました'
    redirect_to comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(
      :text
    ).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
