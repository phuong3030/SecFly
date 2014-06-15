class Admin::DashboardController < ApplicationController
	before_filter :checkAuthorization
	layout 'admin'

	def index 
	end

	private
	def checkAuthorization
		redirect_to admin_login_path unless session[:logged_in] 
	end
end
