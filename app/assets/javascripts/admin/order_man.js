(function ($, scope) {

	// Create connection to server and subcribe to special channel
	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.channel = dis.subscribe('orders_management_man');

	// Binding event from user and send data to server
	$('tbody').on('click', '.view-detail', function(e) {

		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('man_view_order', data);
		
		return false;
	});
	$('tbody').on('click', '.view-logs', function(e) {

		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('view_logs', data);
		
		return false;
	});

	// Listen event from server
	dis.on_open = function(data) { 

		console.log('Connection has been established: ', data); 
	}; 

	channel.bind('order_detail', function (data) {

		$('.customer_id').html(data.customer.id);
		$('.customer_name').html(data.customer.name);
		$('.customer_phone').html(data.customer.phone);
		$('.customer_email').html(data.customer.email);

		$('.order_from').html(data.order.from);
		$('.order_to').html(data.order.to);
		$('.order_depart').html(data.order.depart);
		$('.order_return').html(data.order.return);
		$('.order_quantity').html(
			data.order.children + ' children tickets, ' 
			+ data.order.adult + ' adult tickets, ' 
			+ data.order.seniors + ' senior tickets '
		);

		$.magnificPopup.open({
			items: {
				src: ".order-detail",
				type: "inline"
			},
			callbacks: {
				beforeClose: function() {
				}
			}
		});
	});

	channel.bind('view_order_logs', function (data) {

		var i,
		 	 accountMap = {},
			 lstLoggingItems = '',
			 accounts = data.accounts
			 orderProcessings = data.order_processings,
			 statusMap = [
				 "",
			 	 "VIEW ORDER",
				 "SENT EMAIL to customer",
				 "SENT TICKETS to customer"
			 ];

		console.log(data);

		for (i = 0; i < accounts.length; i++) {
			accountMap[accounts[i].id] = accounts[i].username;
		}

		for (i = 0; i < orderProcessings.length; i++) {
			lstLoggingItems = lstLoggingItems 
						+ '<li>' + accountMap[orderProcessings[i].account_id] 
						+ ' ' + statusMap[orderProcessings[i].status] 
						+ ' at ' + orderProcessings[i].created_at + '</li>'
		}

		$('.logs').html($(lstLoggingItems));

		$.magnificPopup.open({
			items: {
				src: ".action-logs",
				type: "inline"
			},
			callbacks: {
				beforeClose: function() {
				}
			}
		});
	});

	// Binding table and filter table event
	$('.footable').bind('footable_breakpoint', function() {

		$('.footable').trigger('footable_expand_first_row');
	}).footable();

})(jQuery, window);
