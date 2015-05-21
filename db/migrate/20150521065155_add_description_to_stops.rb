class AddDescriptionToStops < ActiveRecord::Migration
  def change
    add_column :stops, :description, :text
  end
end
