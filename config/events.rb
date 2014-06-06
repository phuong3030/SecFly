WebsocketRails::EventMap.describe do
	# You can use this file to map incoming events to controller actions.
	# One event can be mapped to any number of controller actions. The
	# actions will be executed in the order they were subscribed.
	#
	# Uncomment and edit the next line to handle the client connected event:
	#   subscribe :client_connected, :to => Controller, :with_method => :method_name
	#
	# Here is an example of mapping namespaced events:
	#   namespace :product do
	#     subscribe :new, :to => ProductController, :with_method => :new_product
	#   end
	# The above will handle an event triggered on the client like `product.new`.
	
	subscribe :client_connected, 'websockets/socket#connected'
	subscribe :client_connected, 'websockets/socket#disconnected'

	subscribe :man_view_order, 'websockets/admin/orders/order_man#view_order'
	subscribe :view_logs, 'websockets/admin/orders/order_man#view_logs'

	subscribe :view_order, 'websockets/admin/orders/order_emp#view_order'
	subscribe :preview_email, 'websockets/admin/orders/order_emp#preview_email'
	subscribe :send_email, 'websockets/admin/orders/order_emp#send_email_to_customer'
	subscribe :send_ticket, 'websockets/admin/orders/order_emp#send_ticket_to_customer'

end
