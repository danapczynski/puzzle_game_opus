class LevelsController < ApplicationController

  def show
    @level = Level.find_by_level_number(params[:id])
    @score = Score.new(user_id: current_user.id, level_id: @level.id)
    @blocks = @level.playable_blocks
    @solution = @level.solution
  end

end