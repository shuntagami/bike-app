class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if @user.followed_by?(current_user)
      current_user.unfollow(@user)
    else
      current_user.follow(@user)
    end
    respond_to do |format|
      format.html { refirect_to @user }
      format.js
    end
  end
end
