class StaticPagesController < ApplicationController

  def index
    if logged_in?
      redirect_to current_user
    end
  end

  def about
    render layout: false
  end
end
