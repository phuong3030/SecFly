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
						+ ' at ' + new Date(orderProcessings[i].created_at).toLocaleString() + '</li>'
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

	// Listen event new request ticket by customer
	orderMan.bind('new_request', function (data) {
	
		var footable = $('table').data('footable'),
			 newRow,
			 statusMap = [
				 "<span class='order_status new'>NEW</span>",
			 	 "<span class='order_status view-order'>VIEW ORDER</span>",
				 "<span class='order_status sent-email'>SENT EMAIL</span>",
				 "<span class='order_status sent-tickets'>SENT TICKETS</span>"
			 ];		
	
		newRow =	$(
			'<tr><td>' + data.customer.name + '</td><td>'  
			+ data.order.from + '</td><td>' + data.order.to + '</td><td>'
			+ data.order.depart_date + '</td><td>' 
			+ (data.order.return_date || '&nbsp;') + '</td><td>'
			+ new Date(data.order.created_at).toLocaleString() + '</td><td>' 
			+ statusMap[data.order.status] + '</td><td>' 
			+ '<button class="view-detail btn btn-primary btn-sm" href="#" data-order_id="' 
			+ data.order.id + '">View detail</button>' + '</td><td>'
			+ '<button class="view-logs btn btn-primary btn-sm" href="#" data-order_id="' 
			+ data.order.id + '">View logs</button>' + '</td><td>'
		);

	   footable.appendRow(newRow);
	});

	// Binding table and filter table event
	$('.footable').bind('footable_breakpoint', function() {

		$('.footable').trigger('footable_expand_first_row');
	}).footable();

})(jQuery, window);
