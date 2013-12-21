class SessionsController < ApplicationController

  def create
    if User.find_by_email(params[:email])
      @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        login(@user)
      else
        @errors = 'Incorrect email/password combination. Please try again.'
      end
    else
      @errors = "We don't have an account registered to #{params[:email]}. Perhaps you should create one."
    end
    render 'static_pages/index'
  end

  def destroy
    session.clear
    render 'static_pages/index'
  end

end