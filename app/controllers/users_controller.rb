class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
    @like_posts = @user.like_posts
  end

  def edit
    @user = User.find(params[:id])
  end
end
