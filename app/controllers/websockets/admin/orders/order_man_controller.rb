class Websockets::Admin::Orders::OrderManController < WebsocketRails::BaseController

	filter_for_channels :orders_management_man
	before_action :get_order_data

	def view_order
		if (@order != nil && @account != nil)
			WebsocketRails[@account[:username]].trigger(
				:order_detail, 
				{ :order => @order, :customer => @order.customer }
			)
		else
			WebsocketRails[:orders_management_man].trigger(:error, "Order not found")
		end
	end

	def view_logs
		if (@order != nil && @account != nil)
			WebsocketRails[@account[:username]].trigger(
				:view_order_logs, 
				{ 
					:order => @order, 
					:order_processings => @order.order_processings,
					:accounts => @order.accounts.map { |acc| acc.slice(:id, :username) }
				}
			)
		else
			WebsocketRails[:orders_management_man].trigger(:error, "Order not found")
		end
	end

	# get order by order_id sent from client
	def get_order_data
		@order = Order.find(message[:order_id].to_i)
		@account = Account.find_by_username(session[:current_user])
	end
end
