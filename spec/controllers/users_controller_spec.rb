require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "", :email => "", :password => "", 
                            :password_confirmation => "" }
  end 

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  it "should have the right title" do
    get 'new'
    response.should have_selector("title", :content => "VideoBin, the Sign up Page")
  end

  it "should have the right title" do
    get 'index'
    response.should have_selector("title", :content => "VideoBin, the UserList Page")
  end

    describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
  end

  describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@user.email, @user.password)
        matching_user.should == @user
      end
    end


  describe "POST 'create'" do

    describe "success" do
    
      it "should create a user" do
        lambda do
          post :create, :user => @attr.merge!(:email => "test@bla.com",
                                              :name => "Gilbert",
                                              :password => "123456er",
                                              :password_confirmation => "123456er")
        end.should change(User, :count).by(1)
      end

    end

    describe "failure" do

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

       it "should not sign the user in" do
        post :create, :user => @attr
        controller.should_not be_signed_in
      end
    end
  end


  describe "GET 'show'" do
  
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

    describe "signed in" do
    
      describe "on own profile" do

        before(:each) do
          @video = Factory(:video, :user_id => @user)
          @user.videos.push(@video)
          test_sign_in(@user)
          get :show, :id => @user
        end

        it "should show a users videos" do
          response.should have_selector("a", :href => video_path(@video))
        end

        it "should show delete video link" do
          response.should have_selector("a", :href =>video_path(@video), :'data-method' => 'delete')  
        end

        it "should show edit button for videos" do
          response.should have_selector("a", :href => edit_video_path(@video))
        end
      end

      describe "on other profile" do
      
        before(:each) do
          @video = Factory(:video, :user_id => @user)
          @user.videos.push(@video)
          @otherUser = Factory(:user, :email => "yetanohter@mail.com")
          test_sign_in(@otherUser)
          get :show, :id => @user
        end

        it "should show a users videos" do
          response.should have_selector("a", :href => video_path(@video))
        end

        it "should not show delete video" do
          response.should_not have_selector("a", :href =>video_path(@video), :'data-method' => 'delete')  
        end

        it "should not show edit video link" do
          response.should_not have_selector("a", :href => edit_video_path(@video))
        end
      end
    end

    describe "not logged in" do

      before(:each) do
        @video = Factory(:video, :user_id => @user)
        @user.videos.push(@video)
        get :show, :id => @user
      end

      it "should show a users videos" do
        response.should have_selector("a", :href => video_path(@video))
      end

      it "should not show an edit button" do
        response.should_not have_selector("a", :href => edit_video_path(@video))
      end

      it "should not show a delete button" do
        response.should_not have_selector("a", :href =>video_path(@video), :'data-method' => 'delete')  
      end
    end

  end

  describe "DELETE 'destroy'" do

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end
end
