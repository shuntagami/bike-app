class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, flash: { success: "新規投稿が完了しました！" }
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
    @posts = Post.includes(:user).order(id: "DESC")
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(id: "DESC")
    @like = Like.find_by(post_id: @post.id)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, flash: { success: "投稿を更新しました！" }
    else
      puts_error_message
    end
  end

  private
  def post_params
    params.require(:post).permit(:image, :name, :description, :cc_id, :maker_id, :type_id).merge(user_id: current_user.id)
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
