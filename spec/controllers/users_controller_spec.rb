require 'spec_helper'

describe UsersController do
  render_views
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

end
