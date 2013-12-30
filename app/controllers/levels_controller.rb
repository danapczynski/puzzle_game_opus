class LevelsController < ApplicationController
  before_filter :authenticate

  def show
    @level = Level.find_by_level_number(params[:id])
    @score = Score.new
    @blocks = @level.playable_blocks
    @solution = @level.solution
  end

  private

    def authenticate
      if params[:id]
        @level = Level.find_by_level_number(params[:id])
        unless !@level.nil? && logged_in? && (current_user.next_level == @level || current_user.levels.include?(@level))
          redirect_to root_path
        end
      end
    end

end