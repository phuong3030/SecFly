class Admin::OrdersController < Admin::DashboardController

	# Get customer orders summary page
	def index 
	end

	# Get customer orders management page for employee
	def orders_management_by_emp
		@orders = Order.all		
	end

	# Get customer orders management page for manager
	def orders_management_by_man
		@orders = Order.all		
	end

	# Get report
	def orders_man_report
		@employees = Account.get_by_group()
		@orders = Order.create_report(
			params[:start], 
			params[:end], 
			params[:employee]
		)
		
		respond_to do |format|
			format.html
			format.xlsx { 
				send_data(
					@orders.to_xlsx.to_stream.read, 
					:filename => 'report.xlsx' 
				)
			}
		end
	end

end
