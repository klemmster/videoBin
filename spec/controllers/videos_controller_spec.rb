require 'spec_helper'

describe VideosController do
  render_views

  before(:each) do
          @attr = {:name => "TestName",
                   :description => "TestDescription",
                   :user_id => 1,
                   :origfile =>  File.new(Rails.root + 'spec/fixtures/videos/oceans-clip.mp4')
                   }
          @user = Factory(:user)
          @video = @user.videos.create(@attr)
  end

  describe "GET 'new'" do
    it "should not open when not signed in" do
      get 'new'
      response.should redirect_to(signin_path)
    end

    it "should open when signed in" do
      test_sign_in(@user)
      get :new
      response.should be_success
    end

  end

  describe "Post" do
    describe "Create" do
      describe "Signed In" do

        it "should not create a new video" do
          lambda do
            post :create, :video => @video
          end.should_not change(Video, :count).by(1)
        end
          
        it "should create a new video" do
          lambda do
            test_sign_in(@user)
            post :create, :video => @attr
          end.should change(Video, :count).by(1)
        end

      end
      describe "Logged Out" do
        it "should not create a new video" do
          lambda do
            post :create, :video => @attr
          end.should_not change(Video, :count).by(1)
          response.should redirect_to(signin_path)
        end
      end
    end
  end

  describe "GET 'show'" do

    it "should show a video" do
      get :show, :id => @video 
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "should deny access if not logged in" do
      delete :destroy, :id => @video
      response.should redirect_to(signin_path)
    end

    it "should refuse deletion if not users video"

    it "should delete a video" do
      lambda do
        test_sign_in(@user)
        delete :destroy, :id => @video
      end.should change(Video, :count).by(-1)
    end
  end

  describe "GET 'edit'" do
    it "Edit Page should redirect to sign_in if logged out" do
      get :edit, :id => @video
      response.should redirect_to(signin_path)
    end

    it "Edit Page should open" do
      test_sign_in(@user)
      get :edit, :id => @video
      response.should be_success
    end

    it "should refuse update if logged out" do
      put :update, :id => @video, :video => @attr.merge(:name =>"NoName")
      response.should redirect_to(signin_path)
    end

    it "Should update Video Attributes" do
      test_sign_in(@user)
      put :update, :id => @video, :video => @attr.merge(:name =>"NoName")
      @video.reload
      @video.name.should  == "NoName" 
      @video.description.should == @attr[:description]
    end
  end
  
  describe "Get Index" do
    describe "as SignedIn user" do
      before(:each) to
          test_sign_in(@user)
          get :index
      end
  
      describe "Success" do

        it "should link to a video" do
          response.should have_selector("a", :href => video_path(@video))
        end

        it "should link to a video_owner" do
          response.should have_selector("a", :href => user_path(@user)) 
        end

      end

      describe "Failure" do

        it "should not link to edit video" do
          response.should_not have_selector("a", :href => edit_video_path(@video))
        end

        it "should_not link to delete a video" do
          response.should_not have_selector("a", :href => video_path(@video), :'data-method' => 'delete')
        end
      end
    end
    
    describe "as loggedOut user" do
      before(:each) do
        get :index
      end

      describe "success" do

        it "should link to a video" do
          response.should have_selector("a", :href => video_path(@video))
        end

        it "should link to a video_owner" do
          response.should have_selector("a", :href => user_path(@user)) 
        end
      end

      describe "failure" do
        it "should not show an edit link" do
          response.should_not have_selector("a", :href => edit_video_path(@video))
        end
        it "should not show a delete link" do
          response.should_not have_selector("a", :href => video_path(@video), :'data-method' => 'delete')
        end
      end
    end
  end
end
