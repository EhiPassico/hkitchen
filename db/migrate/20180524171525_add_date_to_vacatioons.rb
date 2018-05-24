class AddDateToVacatioons < ActiveRecord::Migration
  def change
    add_column :vacations, :vacation_date, :string
    add_index :vacations, :vacation_date
  end
end
