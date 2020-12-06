# frozen_string_literal: true

# class RelationshipsController < ApplicationController
#   before_action :redirect_to_root

#   def create
#     @user = User.find(params[:user_id])
#     if @user.followed_by?(current_user)
#       current_user.unfollow(@user)
#     else
#       current_user.follow(@user)
#     end
#     json = { followers_count: @user.followers.count,
#              following_count: current_user.following.count,
#              current_user_in_followers: @user.followers.include?(current_user) }
#     render json: json
#   end
# end

class RelationshipsController < ApplicationController
  # before_action :logged_in_user

  # POST /relationships
  def create
    # @user = User.find(params[:user_id])
    @user = User.find(params[:followed_id])
    @relationship = current_user.follow(@user) # DB 更新
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # => app/views/relationships/create.js.erb
      format.json { render json: current_user.active_relationships.find_by(followed_id: @user.id) }
    end
  end
  
  # DELETE /relationships/:id
  def destroy
    # @user = User.find(params[:user_id])
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # => app/views/relationships/destroy.js.erb
      format.json { render json: nil }
    end
  end
end
