class UsersController < ApplicationController
  skip_before_filter :check_authentication, :only => [:new, :create, :show, :index]
  skip_before_filter :current_user, :only => [:new, :create]
  load_and_authorize_resource :except => [:new, :create, :show, :index]

  def new
    @user = User.new
    @action = "Sign Up"
  end

  def create
    @user = User.new( params[:user] )
    if @user.save
      flash[:success] = "Welcome, #{@user[:username]}! Enjoy your Odysseys!"
      redirect_to @user
    else
      flash[:alert] = "There was an error creating your account."
      render 'new'
    end
  end

  def show
    @user = User.find( params[:id] )
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find( params[:id] )
    @action = "Update your profile"
  end

  def update
    @user = User.find( params[:id] )
    if @user.save
      flash[:success] = "Your user has been updated successfully."
      redirect_to @user
    else
      flash[:alert] = "There was an error updating your user."
      render 'edit'
    end
  end

end
