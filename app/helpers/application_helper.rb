module ApplicationHelper
	def show_collection(collection)
		if collection.blank?
			flash["notice"] = 'No record.'
			''
		else
			render collection
		end
	end
end
