require 'spec_helper'

describe VideosController do
  render_views

  before(:each) do
          @attr = {:name => "TestName", :description => "TestDescription" }
          @video = Video.new(@attr)
          @video.origfile = File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4') 
          @video.save
  end

  describe "GET 'new'" do
    it "should create a new video" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do

    it "should show a video" do
      get :show, :id => @video 
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "should delete a video" do
      lambda do
        delete :destroy, :id => @video
      end.should change(Video, :count).by(-1)
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

end
