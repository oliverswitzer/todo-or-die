class AddFriends < ActiveRecord::Migration
  def change
    create_table(:friends) do |t|
      t.string :name
      t.belongs_to :user

      t.timestamps
    end
  end
end
