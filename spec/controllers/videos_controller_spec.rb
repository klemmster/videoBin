require 'spec_helper'

describe VideosController do
  render_views

  before(:each) do
          @attr = {:name => "TestName",
                   :description => "TestDescription",
                   :user_id => 1
                   }
          @user = Factory(:user)
          @video = @user.videos.new(@attr)
          @video.origfile = File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4') 
          @video.save
  end

  describe "GET 'new'" do
    it "should open new video page" do
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
    it "Edit Page should open" do
      get :edit, :id => @video
      response.should be_success
    end

    it "Should update Video Attributes" do
      put :update, :id => @video, :video => @attr.merge(:name =>"NoName")
      @video.reload
      @video.name.should  == "NoName" 
      @video.description.should == @attr[:description]
    end
  end

end
