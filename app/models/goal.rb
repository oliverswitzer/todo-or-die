class Goal < ActiveRecord::Base
  as_enum :goal_type, [:novel, :coding_project, :blog], map: :string
  belongs_to :user
end