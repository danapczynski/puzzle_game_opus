class ScoresController < ApplicationController

  def create
    @score = Score.create!(params[:score])
    current_user.scores << @score
    render nothing: true
  end

end