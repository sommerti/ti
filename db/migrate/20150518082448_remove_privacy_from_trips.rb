class RemovePrivacyFromTrips < ActiveRecord::Migration
  def change
  	remove_column :trips, :privacy
  end
end
