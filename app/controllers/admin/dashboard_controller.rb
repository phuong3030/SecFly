class Admin::DashboardController < ApplicationController

	layout 'admin'
	before_filter :checkAuthorization

	def index 
	end

	private
	def checkAuthorization
		redirect_to admin_login_path unless session[:logged_in] 
	end

end
