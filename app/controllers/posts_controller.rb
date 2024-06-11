class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.includes(:user)
  end
end
