module TripsHelper
	def show_trips(trips)
		if trips.blank?
			flash["notice"] = 'No trip to show.'
			''
		else
			render trips
		end
	end
end
