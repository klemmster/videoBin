require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end


  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign In")
    end

    it "should have a signup link" do
      visit root_path
      response.should have_selector("a", :href =>signup_path,
                                         :content => "Sign Up")
    end

    it "should not have a sign out link" do
      visit root_path
      response.should_not have_selector("a", :href => signout_path,
                                             :content => "Sign out")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    describe "success" do

      it "should have a signout link" do
        visit root_path
        response.should have_selector("a", :href => signout_path,
                                           :content => "Sign out")
      end

      it "should have a profile link" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user),
                                           :content => "Profile")
      end

       it "should have a profile link" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user),
                                           :content => "Profile")
      end
    end
    
    describe "failure" do

      it "should not have a sign in link" do
        visit root_path
        response.should_not have_selector("a", :href => signin_path,
                                               :content => "Sign In")
      end
      
      it "should not have a sign up link" do
        visit root_path
        response.should_not have_selector("a", :href => signup_path,
                                               :content => "Sign Up")
      end
    end
  end
end

