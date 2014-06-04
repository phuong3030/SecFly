class Websockets::Admin::Orders::OrderEmpController < WebsocketRails::BaseController

	filter_for_channels :orders_management_emp

	def view_order

		WebsocketRails[:orders_management_man].trigger(:view_order, message)
	end

	def send_email_to_customer
		WebsocketRails[:orders_management_man].trigger(:send_email, message)
	end

	def send_ticket_to_customer
		WebsocketRails[:orders_management_man].trigger(:send_ticket, message)
	end

end
