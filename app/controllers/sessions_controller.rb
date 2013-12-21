class SessionsController < ApplicationController

  def create
    if User.find_by_email(params[:email])
      @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        login(@user)
        redirect_to :back
      else
        # incorrect password
      end
    else
      # incorrect email
    end
  end

  def destroy
    session.clear
    redirect_to :back
  end

end