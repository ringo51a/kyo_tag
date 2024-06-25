class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @tags = Tag.with_posts
  end
end