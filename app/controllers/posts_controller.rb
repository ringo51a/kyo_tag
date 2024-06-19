class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def new
    @post = Post.new
  end

  def index
    posts = if (tag_name = params[:tag_name])
              Post.with_tag(tag_name)
            else
              Post.all
            end
    @posts = posts.includes(:user, :place).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    place_id = params.dig(:post, :place_id)
    place_name = params.dig(:post, :place_name)
    if @post.save_with_tags_and_place(tag_names: params.dig(:post, :tag_names).split(',').uniq, place_id: place_id, place_name: place_name)
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    place_id = params.dig(:post, :place_id)
    place_name = params.dig(:post, :place_name)
    if @post.save_with_tags_and_place(tag_names: params.dig(:post, :tag_names).split(',').uniq, place_id: place_id, place_name: place_name)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at, :post_image, :post_image_cache, place_attributes: [:name, :place_id])
  end
end