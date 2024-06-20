class PlacesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  
  def index
    @places = Place.order(created_at: :desc)
  end

  def show
    @place = Place.find(params[:id])
    @posts = @place.posts
  end
end