class LikesController < ApplicationController
  before_action :find_post

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    @like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
