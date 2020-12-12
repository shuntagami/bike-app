class PostsController < ApplicationController
  before_action :redirect_to_root, only: %i[create update destroy like]
  before_action :find_post, only: %i[show edit update destroy like]
  before_action :set_weathers, :set_feelings, :set_expectations, only: %i[new edit search]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, flash: { success: '新規投稿が完了しました！' }
    else
      puts_error_message
    end
  end

  def edit; end

  def destroy
    @post.destroy
    flash[:success] = '投稿が削除されました'
    redirect_to root_path
  end

  def index
    @posts = Post.includes(:user, :prefecture, :city).order(id: 'DESC')
    @posts = Post.page(params[:page]).per(PER)
    @posts = set_posts_date_range(@posts, params[:date_range])
  end

  def show
    gon.post_id = @post.id
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
      # json = { post_id: @post.id, count: @post.likes.count }
    else
      @like = current_user.likes.new(post_id: @post.id)
      @like.save
      # json = { post_id: @post.id, count: @post.likes.count, like: @like }
    end
    # render json: json
    respond_to do |format|
      format.json
    end
  end

  def popular
    @popular_posts = Post.joins(:likes)
                         .group(:post_id)
                         .order(Arel.sql('count(likes.user_id) desc'))
                         .page(params[:page]).per(PER)
  end

  def feed
    return unless user_signed_in?

    @feed_posts = current_user.feed.page(params[:page]).per(PER)
    @feed_posts = @feed_posts.includes(:user)
  end

  def search
    @search_params = post_search_params
    @search_posts = Post.search(@search_params)
                        .page(params[:page])
                        .per(PER)
                        .includes(:user, :prefecture, :city)
  end

  def cities_select
    render partial: 'cities', locals: { prefecture_id: params[:prefecture_id] } if request.xhr?
  end

  def set_weathers
    @weathers = WEATHERS
  end

  def set_feelings
    @feelings = FEELINGS
  end

  def set_expectations
    @road_condition = ROAD_CONDITION
  end

  private

  def post_params
    params.require(:post).permit(
      :description, :image, :prefecture_id, :city_id, :weather, :feeling, :road_condition
    ).merge(user_id: current_user.id)
  end

  def post_search_params
    params.fetch(:post, {}).permit(:description, :prefecture_id, :city_id, :weather)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def set_form_title_button
    if params['action'] == 'new'
      @form_title = '新しい投稿'
      @form_button = '投稿する'
    else
      @form_title = '投稿を編集'
      @form_button = '更新する'
    end
  end

  def puts_error_message
    redirect_back fallback_location: @post, flash: {
      post: @post,
      error_messages: @post.errors.full_messages
    }
  end

  def set_posts_date_range(posts, date_range)
    from = 1.years.ago.beginning_of_day
    to = Time.zone.now.end_of_day
    case date_range
    when '3days'
      from = 3.days.ago.beginning_of_day
    when 'week'
      from = 1.week.ago.beginning_of_day
    when 'month'
      from = 1.month.ago.beginning_of_day
    end
    posts.where(created_at: from..to)
  end
end
