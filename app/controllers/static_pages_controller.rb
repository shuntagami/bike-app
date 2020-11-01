class StaticPagesController < ApplicationController
  def home
    redirect_to posts_path
  end
end
