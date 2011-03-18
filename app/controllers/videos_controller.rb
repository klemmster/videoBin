class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def create
    @video = Video.new(params[:video])
    @video.length = 400
    if @video.save
      #TODO
    else
      render :new 
    end
  end

  def new
    @video = Video.new
  end

  def show
    @video =Video.find(params[:id])
  end

  def delete
  end

  def update
  end

end
