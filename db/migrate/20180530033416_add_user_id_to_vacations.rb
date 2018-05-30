class AddUserIdToVacations < ActiveRecord::Migration
  def up
    add_column :vacations, :user_id, :integer
    add_index :vacations, :user_id
  end

  def down
    remove_column :vacations, :user_id
  end
end
