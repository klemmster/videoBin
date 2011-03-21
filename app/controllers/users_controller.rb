class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end

  def index
    @title = "User overview"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  @user = User.create( params[:user] )
end


end
