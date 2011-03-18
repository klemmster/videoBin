class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def create

  end

  def new
    @video = Video.create(params[:video])
  end

  def show
    @video =Video.find(params[:id])
  end

  def delete
  end

  def update
  end

end
