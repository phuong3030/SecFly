class Admin::OrdersController < Admin::DashboardController
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
end
