class LikesController < ApplicationController
  before_action :find_post

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @like = Like.new(user_id: current_user.id, proposal_id: params[:proposal_id])
    @like.save
  end

  def destroy
    @proposal = Proposal.find(params[:proposal_id])
    @like = Like.find_by(user_id: current_user.id, proposal_id: params[:proposal_id])
    @like.destroy
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
