class PlacesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  
  def index
    if params[:tag_name].present?
      @tag = Tag.find_by(name: params[:tag_name])
      if @tag
        @places = Place.joins(posts: :taggings).where(taggings: { tag_id: @tag.id }).distinct
      else
        @places = []
      end
    else
      @places = Place.all
    end
  end

  def show
    @place = Place.find(params[:id])
    @posts = @place.posts
  end
end