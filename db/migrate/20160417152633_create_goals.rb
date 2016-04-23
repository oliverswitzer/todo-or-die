class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.timestamp :complete_by
      t.integer :word_count
    end

    add_index :goals, :name
  end
end
