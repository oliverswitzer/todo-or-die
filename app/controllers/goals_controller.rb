class GoalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(sanitized_params.merge(user_id: current_user.id))
    @goal.save

    redirect_to friends_path
  end

  def sanitized_params
    params.require(:goal).permit(:name, :word_count, :complete_by, :goal_type)
  end
end