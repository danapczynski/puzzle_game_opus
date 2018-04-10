class ScoresController < ApplicationController
  def create
    @score = Score.create!(score_params)
    current_user.scores << @score
    head :ok
  end

  private

  def score_params
    params[:score].permit(:user_id, :level_id, :completion_time)
  end
end
