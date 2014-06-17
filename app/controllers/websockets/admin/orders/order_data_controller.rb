class Websockets::Admin::Orders::OrderDataController < WebsocketRails::BaseController

	def get_filtered_order_data
		orders = Order.get_filter_data(
			message[:start_time],
			message[:end_time],
			message[:status]
		)

		WebsocketRails[session[:current_user]].trigger(:order_filtered, orders)
	end

end
