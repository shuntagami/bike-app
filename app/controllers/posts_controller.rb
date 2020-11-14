# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :redirect_to_root, only: %i[create update destroy like]
  before_action :find_post, only: %i[show update destroy like]

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, flash: { success: '新規投稿が完了しました！' }
    else
      puts_error_message
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿が削除されました'
    redirect_to root_path
  end

  def index
    @posts = Post.includes(:user).order(id: 'DESC')
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(id: 'DESC')
    @like = Like.find_by(post_id: @post.id)
  end

  def update
    if @post.update(post_params)
      redirect_to @post, flash: { success: '投稿を更新しました！' }
    else
      puts_error_message
    end
  end

  def like
    if @post.liked_by?(current_user)
      @like = current_user.likes.find_by(post_id: @post.id)
      @like.destroy
      json = { post_id: @post.id, count: @post.likes.count }
    else
      @like = current_user.likes.new(post_id: @post.id)
      @like.save
      json = { post_id: @post.id, count: @post.likes.count, like: @like }
    end
    render json: json
  end

  private

  def post_params
    params.require(:post).permit(
      :image, :description
    ).merge(user_id: current_user.id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def puts_error_message
    redirect_back fallback_location: @post, flash: {
      post: @post,
      error_messages: @post.errors.full_messages
    }
  end
end
