# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_to_root, only: %i[index destroy]
  before_action :admin_user, only: %i[index destroy]
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.order(id: 'DESC')
  end

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
      flash[:success] = 'プロフィールを更新しました！'
    else
      redirect_to @user, flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」は正常に削除されました"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :avatar, bike_attributes: %i[id bike_name cc_id maker_id type_id]
    )
  end

  def find_user
    @user = User.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
