class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(sanitized_params[:goal])
    @goal.save

    render :new
  end

  def sanitized_params
    params.require(:goal).permit(:name, :word_count, :complete_by, :project_type)
  end
end