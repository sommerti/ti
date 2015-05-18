class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.date :begin_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
