module TripsHelper
	def display_one_or_more_trips(trip_or_trips)
		if trip_or_trips.blank?
			("<p>No trip to display.</p>").html_safe
		else
			render trip_or_trips
		end
	end
end
