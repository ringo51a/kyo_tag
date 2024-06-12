class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.includes(:user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at, :post_image)
  end

end