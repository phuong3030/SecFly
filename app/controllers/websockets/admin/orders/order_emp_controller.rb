class Websockets::Admin::Orders::OrderEmpController < WebsocketRails::BaseController

	filter_for_channels :orders_management_emp
	before_action :get_account_order_data

	def view_order
		if (@account != nil && @order != nil)
			# mapping account with order
			@account.orders << @order
	
			# check account is saved, send data back to employee client
			# and trigger event to logging data 
			if @account.save
				WebsocketRails[:orders_management_man].trigger(:emp_view_order, @order)
				WebsocketRails[:orders_management_emp].trigger(:order_detail, @order)
			end
		else
			WebsocketRails[:orders_management_emp].trigger(:error, "Account or order not found")
		end
	end

	def send_email_to_customer
		if (@account != nil && @order != nil)	
			WebsocketRails[:orders_management_man].trigger(:send_email, message)
		end
	end

	def send_ticket_to_customer
		# confirm to employee client update order table and trigger event 
		# to log action
		if (@account != nil && @order != nil)	
			WebsocketRails[:orders_management_man].trigger(:send_ticket, message)
		end
	end

	# get account by session and order by order_id sent from client
	def get_account_order_data
		@order = Order.find(message[:order_id].to_i)
		@account = Account.find_by_username(session[:current_user])
	end
end
