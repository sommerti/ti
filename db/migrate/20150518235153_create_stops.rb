class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.references :country, index: true, foreign_key: true
      t.references :region, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.date :begin_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
