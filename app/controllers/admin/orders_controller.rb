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
		@orders = []
		start_time = params[:start]
		end_time = params[:end]
		emp_id = params[:employee]

		# Order filter and get data to export to excel
		if start_time && end_time
			if emp_id 
				@orders = Order.report_by_emp_date_range(start_time.to_date, end_time.to_date, emp_id)
			else
				@orders = Order.filter_by_date_range_status(start_time.to_date, end_time.to_date, 3)
			end
		else
			if emp_id 
				@orders = Order.report_by_emp_date_range(30.days.ago, Date.today, emp_id)
			else
				@orders = Order.filter_by_date_range_status(30.days.ago, Date.today, 3)
			end
		end

		respond_to do |format|
			format.html
			format.xls
		end
	end
end
