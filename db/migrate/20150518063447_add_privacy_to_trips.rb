class AddPrivacyToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :privacy, :string
  end
end
