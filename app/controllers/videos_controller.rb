class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def create
    @video = Video.new(params[:video])
    @video.length = 400
    if @video.save
      redirect_to videos_url
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

  def destroy
    Video.find(params[:id]).destroy
    redirect_to videos_url
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:video])
    @video.update_attributes(params[:video])
  end

end
