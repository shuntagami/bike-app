class UsersController < ApplicationController
  before_action :find_user
  def show
    gon.user_id = @user.id
    gon.current_user_id = current_user.id if user_signed_in? 
    @posts = @user.posts
    @likes = Like.where(user_id: @user.id)
    @like_posts = @user.like_posts
    @followings = @user.following
    @followers = @user.followers
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to edit_user_path(@user), flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
