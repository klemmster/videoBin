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
    response.should have_selector("title", :content => "Tutorial, the Sign up Page")
  end

  it "should have the right title" do
    get 'index'
    response.should have_selector("title", :content => "Tutorial, the User overview Page")
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

       it "should sign the user in" do
        post :create, :user => @attr.merge(:email => "aaa@bbb.ccc", :password => "test111" )
        controller.should be_signed_in
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
  end
end
