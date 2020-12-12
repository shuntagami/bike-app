class RelationshipsController < ApplicationController
  before_action :redirect_to_root

  def create
    @user = User.find(params[:user_id])
    if @user.followed_by?(current_user)
      current_user.unfollow(@user)
    else
      current_user.follow(@user)
    end
    respond_to do |format|
      format.json
    end
  end
end
