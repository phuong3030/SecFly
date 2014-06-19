class Admin::DashboardController < ApplicationController

	layout 'admin'
	before_filter :check_authorization

	def index 
	end

	private
	def check_authorization
		redirect_to admin_login_path unless session[:logged_in] 
	end

end
