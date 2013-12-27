class UsersController < ApplicationController
  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.new(params[:user])
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
end