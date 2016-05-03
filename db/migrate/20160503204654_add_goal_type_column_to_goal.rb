class AddGoalTypeColumnToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :goal_type_cd, :integer
  end
end
