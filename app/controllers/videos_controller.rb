class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
  end

  def show
	@video =Video.find(params[:id])
  end

  def delete
  end

  def update
  end

end
