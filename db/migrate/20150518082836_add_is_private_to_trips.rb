class AddIsPrivateToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :is_private, :boolean
  end
end
