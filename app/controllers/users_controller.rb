class UsersController < ApplicationController
  before_action :authenticate

  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to @user
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def authenticate
    if params[:id]
      begin
        @user = User.find(params[:id])
      rescue
        @user = nil
      end
      unless logged_in? && current_user == @user
        redirect_to root_path
      end
    end
  end

  def user_params
    params[:user].permit(:name, :email, :password)
  end
end
