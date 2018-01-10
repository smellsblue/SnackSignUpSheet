class CreateSignups < ActiveRecord::Migration[5.1]
  def change
    create_table :available_dates do |t|
      t.date :day, null: false
      t.string :name
      t.timestamps
    end
  end
end
