class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @tags = Tag.order(created_at: :desc)
  end
end