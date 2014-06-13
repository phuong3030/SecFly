(function ($, scope) {

	// Subcribe to special channel
	scope.orderMan = dis.subscribe('orders_management_man');

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
	privateChannel.bind('order_detail', function (data) {

		var adult_tickets = data.order.adult_names !== '' ? data.order.adult_names.split(';') : [],
			 children_tickets = data.order.children_names !== '' ? data.order.children_names.split(';') : [],
			 infant_tickets = data.order.infant_names !== '' ? data.order.infant_names.split(';') : [];

		$('.customer_id').html(data.customer.id);
		$('.customer_name').html(data.customer.name);
		$('.customer_phone').html(data.customer.phone);
		$('.customer_email').html(data.customer.email);

		$('.order_from').html(data.order.from);
		$('.order_to').html(data.order.to);
		$('.order_depart').html(data.order.depart_date);
		$('.order_return').html(data.order.return_date || '&nbsp;');
		$('.order_adult_tickets').html(adult_tickets.length + ' adult ticket(s): ' + '</br>' + adult_tickets.join('</br>'));
		$('.order_children_tickets').html(children_tickets.length + ' children ticket(s): ' + '</br>' + children_tickets.join('</br>'));
		$('.order_infant_tickets').html(infant_tickets.length + ' infant ticket(s): ' + '</br>' + infant_tickets.join('</br>'));

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

	privateChannel.bind('view_order_logs', function (data) {

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

	// Listen event from employee
	orderMan.bind('order_emp_view_order', function(data) {

		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status viewed').html('VIEWED');	
	});
	orderMan.bind('order_emp_send_email', function(data) {
	
		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status sent-email').html('SENT EMAIL');	
	});
	orderMan.bind('order_emp_send_ticket', function(data) {
	
		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status sent-tickets').html('SENT TICKETS');	
	});

	// Binding table and filter table event
	$('.footable').bind('footable_breakpoint', function() {

		$('.footable').trigger('footable_expand_first_row');
	}).footable();

})(jQuery, window);
