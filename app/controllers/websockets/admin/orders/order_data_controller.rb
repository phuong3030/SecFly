class Websockets::Admin::Orders::OrderDataController < WebsocketRails::BaseController

	def get_filtered_order_data
		start_time = message[:start_time]
		end_time = message[:end_time]
		status = message[:status]
		order = []

		if start_time && end_time
			orders = Order.filter_by_date_range_status(start_time.to_date, end_time.to_date, status)
		else 
			orders = Order.filter_by_status(status)
		end

		WebsocketRails[session[:current_user]].trigger(:order_filtered, orders)
	end

end
