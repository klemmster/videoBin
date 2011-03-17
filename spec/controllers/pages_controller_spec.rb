require 'spec_helper'

describe PagesController do
render_views
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
       get 'about'
       response.should 
       have_selector("title", :content => "Tutorial, the Home Page")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
       get 'about'
       response.should 
       have_selector("title", :content => "Tutorial, the Contact Page")
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
       get 'about'
       response.should 
       have_selector("title", :content => "Tutorial, the About Page")
    end
 
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
       get 'help'
       response.should 
       have_selector("title", :content => "Tutorial, the HELP Page")
    end
 
  end

 
end
