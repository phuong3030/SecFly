class Admin::OrdersController < ApplicationController
	before_filter :checkAuthorization
	layout 'admin'

	# Get customer orders summary page
	def index 

	end

	# get customer orders management page for employee
	def orders_management_by_emp
		@orders = Order.all		
	end

	# get customer orders management page for manager
	def orders_management_by_man
		@orders = Order.all		
	end

	def checkAuthorization
		redirect_to admin_login_path unless session[:logged_in] 
	end
end
