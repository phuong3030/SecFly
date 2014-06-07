class Websockets::Admin::Orders::OrderEmpController < WebsocketRails::BaseController

	filter_for_channels :orders_management_emp
	before_action :get_account_order_data

	def view_order
		if (@account != nil && @order != nil)
			# update current status for order and mapping account with order
			@order.status = 1
			@account.orders << @order
	
			# check account is saved, send data back to employee client
			# and trigger event to logging data 
			if @account.save
				WebsocketRails[:orders_management_man].trigger(
					:emp_view_order, 
					{ :order => @order, :customer => @order.customer }
				)
				WebsocketRails[:orders_management_emp].trigger(
					:order_detail, 
					{ :order => @order, :customer => @order.customer }
				)
			end
		else
			WebsocketRails[:orders_management_emp].trigger(:error, "Account or order not found")
		end
	end

	def preview_email
		# Create email form sent back to employee client and log employee action
		if (@account != nil && @order != nil)	
			if @order.status < 2
				@order.status = 2
			end
			logging = OrderProcessing.new(:order_id => @order.id, :account_id => @account.id, :status => 2)
			
			if (@order.save && logging.save) 
			WebsocketRails[:orders_management_emp].trigger(
				:order_customer_preview_email, 
				@order
			)
			end
		end
	end

	def send_email_to_customer
		# Create email form sent back to employee client and log employee action
		if (@account != nil && @order != nil)	
			if @order.status < 2
				@order.status = 2
			end
			logging = OrderProcessing.new(:order_id => @order.id, :account_id => @account.id, :status => 2)
			
			if (@order.save && logging.save) 
				WebsocketRails[:orders_management_emp].trigger(
					:order_customer_send_email, 
					{ :order => @order, :customer => @order.customer }
				)
				WebsocketRails[:orders_management_man].trigger(
					:send_email, 
					{ :order => @order, :customer => @order.customer }
				)
			end
		end
	end

	def send_ticket_to_customer
		# confirm to employee client update order table and trigger event 
		# to log action
		if (@account != nil && @order != nil)	
			if @order.status < 3
				@order.status = 3
			end
			logging = OrderProcessing.new(:order_id => @order.id, :account_id => @account.id, :status => 3)

			if (@order.save && logging.save) 
				WebsocketRails[:orders_management_emp].trigger(
					:order_customer_email, 
					{ :order => @order, :customer => @order.customer }
				)
				WebsocketRails[:orders_management_man].trigger(
					:send_ticket, 
					{ :order => @order, :customer => @order.customer }
				)
			end
		end
	end

	# get account by session and order by order_id sent from client
	def get_account_order_data
		@order = Order.find(message[:order_id].to_i)
		@account = Account.find_by_username(session[:current_user])
	end
end
