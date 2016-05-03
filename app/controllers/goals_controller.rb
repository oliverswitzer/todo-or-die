class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(sanitized_params)
    @goal.save

    redirect_to friends_path
  end

  def sanitized_params
    params.require(:goal).permit(:name, :word_count, :complete_by, :goal_type)
  end
end