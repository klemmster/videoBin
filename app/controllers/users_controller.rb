class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  @user = User.create( params[:user] )
  end


end
