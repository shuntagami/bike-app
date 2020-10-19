class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
  end
end
