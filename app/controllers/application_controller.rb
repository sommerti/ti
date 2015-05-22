class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception


	def capitalize_input(input)
	input.downcase.split(' ').map(&:capitalize).join(' ')
	end

  	rescue_from CanCan::AccessDenied do |exception|
		flash[:alert] = "Not authorized."
		redirect_to :back
	end

end
