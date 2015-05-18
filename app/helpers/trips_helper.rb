module TripsHelper
	def display_one_or_more_trips(trip_or_trips)
		if trip_or_trips.blank?
			"No trip to display."
		else
			render trip_or_trips
		end
	end
end
