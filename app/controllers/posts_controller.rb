class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(id: "DESC")
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(id: "DESC").includes(:user)
  end

  private
  def post_params
    params.require(:post).permit(:image, :name, :description, :cc_id, :maker_id, :type_id).merge(user_id: current_user.id)
  end
end
