require 'spec_helper'

describe VideosController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do

    before(:each) do
            @attr = {:name => "TestName", :description => "TestDescription" }
            @video = Video.new(@attr)
            @video.origfile = File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4') 
    end

    it "should be successful" do
      get :show, :id => @video 
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "should be successful" do
      get 'delete'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

end
