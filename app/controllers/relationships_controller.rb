class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    # respond_to do |format|
    #   format.html { refirect_to @user }
    #   format.js
    # end
    render json:{ user: user }
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    # respond_to do |format|
    #   format.html { refirect_to user }
    #   format.js
    # end
    render json:{ user: user }
  end
end
