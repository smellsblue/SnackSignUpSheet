class AddIndexToAvailableDates < ActiveRecord::Migration[5.1]
  def change
    add_index :available_dates, :day
  end
end
