class AddDatesDescriptionToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :begin_date, :date
    add_column :locations, :end_date, :date
    add_column :locations, :description, :text
  end
end
