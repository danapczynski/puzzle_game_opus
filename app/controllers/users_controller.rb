class UsersController < ApplicationController
  before_filter :authenticate

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
end