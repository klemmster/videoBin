class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def index
    @title = "User overview"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end



#  def create
#  @user = User.create( params[:user] )
#  end
#
#  def create
#    @user = User.new(params[:user])
#    if @user.save
#      # Handle a successful save.
#    else
#      @title = "Sign up"
#      render 'new'
#    end
#  end
#
#  def create
#    @user = User.new(params[:user])
#    if @user.save
#      redirect_to @user
#    else
#      @title = "Sign up"
#      render 'new'
#    end
#  end

#   def create
#    @user = User.new(params[:user])
#    if @user.save
#      flash[:success] = "Welcome to the Sample App!"
#      redirect_to @user
#    else
#      @title = "Sign up"
#      render 'new'
#    end
#  end





end
