# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    redirect_to posts_path
  end
end
