class SessionsController < ApplicationController

  def new
    render layout: false
  end

  def create
    if User.find_by_email(params[:email])
      @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        login(@user)
        redirect_to root_path
      else
        @errors = 'Incorrect email/password combination. Please try again.'
        render 'new', layout: 'application'
      end
    else
      @errors = "We don't have an account registered to that email address. Please try again."
      render 'new', layout: 'application'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end