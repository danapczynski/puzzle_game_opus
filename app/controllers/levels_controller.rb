class LevelsController < ApplicationController

  def show
    @level = Level.find_by_level_number(params[:id])
    @blocks = @level.playable_blocks
    @solution = @level.solution
  end

end