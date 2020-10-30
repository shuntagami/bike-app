class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    json = { followers_count: @user.followers.count, following_count: current_user.following.count, follower_judgment: @user.followers.include?(current_user)}
    render json: json
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    json = { followers_count: @user.followers.count, following_count: current_user.following.count, follower_judgment: @user.followers.include?(current_user)}
    render json: json
  end
end