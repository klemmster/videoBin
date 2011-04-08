class VideosController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy, :edit, :update]

  def index
    @videos = Video.paginate(:page => params[:page])
  end

  def create
    @video = current_user.videos.new(params[:video])
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
    @embed = render_to_string 'embedVideo', :layout => false
    @embed.gsub!("/system", "system") #Get rid of double slashes in link
    @embed = CGI.escapeHTML(@embed)
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
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:success] = "Video Updated"
      redirect_to @video
    else
      render :edit
    end
  end

end
