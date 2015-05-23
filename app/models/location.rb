# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string
#  latitude    :float
#  longitude   :float
#  trip_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  begin_date  :date
#  end_date    :date
#  description :text
#

class Location < ActiveRecord::Base
	belongs_to :trip

	geocoded_by :name
	after_validation :geocode, if: :name_changed? 
end
