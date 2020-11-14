# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :redirect_to_root

  def create
    @user = User.find(params[:user_id])
    if @user.followed_by?(current_user)
      current_user.unfollow(@user)
    else
      current_user.follow(@user)
    end
    json = { followers_count: @user.followers.count,
             following_count: current_user.following.count,
             current_user_in_followers: @user.followers.include?(current_user) }
    render json: json
  end
end
