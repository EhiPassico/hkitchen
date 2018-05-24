class CreateVacations < ActiveRecord::Migration
  def up
    create_table :vacations do |t|
      t.string :description
      t.integer :status
      t.timestamps null: false
    end

    add_index :vacations, :description
    add_index :vacations, :status
  end

  def down
    drop_table :vacations
  end
end
