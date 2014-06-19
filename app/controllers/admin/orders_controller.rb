class Admin::OrdersController < Admin::DashboardController

	before_filter :get_role

	# Get customer orders summary page
	def index 
	end

	# Get customer orders management page for employee
	def orders_management_by_emp
		if @role 
			@orders = Order.all		
		else 
			redirect_to(
				admin_dashboard_index_path, 
				:notice => "You don't have permission to access this page"
			)
		end
	end

	# Get customer orders management page for manager
	def orders_management_by_man
		if @role < 4 
			@orders = Order.all		
		else 
			redirect_to(
				admin_dashboard_index_path, 
				:notice => "You don't have permission to access this page"
			)
		end
	end

	# Get report
	def orders_man_report
		if @role < 4 
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
		else 
			redirect_to(
				admin_dashboard_index_path, 
				:notice => "You don't have permission to access this page"
			)
		end

	end

	private
	def get_role 
		account = Account.find_by_username(session[:current_user])
		@role = account.get_role
	end

end
