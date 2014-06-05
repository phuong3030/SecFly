(function ($, scope) {

	// Create connection to server and subcribe to special channel
	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.channel = dis.subscribe('orders_management_emp');

	// Binding event from user and send data to server
	$('tbody').on('click', '.view-order', function(e) {

		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('view_order', data);
		
		return false;
	});
	$('tbody').on('click', '.send-email', function(e) {

		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('send_email', data);
		
		return false;
	});
	$('tbody').on('click', '.send-ticket', function(e) {
		
		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('send_ticket', data);

		return false;
	});

	// Listen event from server
	dis.on_open = function(data) {

		console.log('Connection has been established: ', data);
	}

	channel.bind('order_detail', function (data) {

		console.log(data);
	});

	channel.bind('order_customer_email', function (data) {

		console.log(data);
	});

	channel.bind('order_customer_tickets', function (data) {

		console.log(data);
	});

	channel.bind('new_request', function (data) {
	
		var footable = $('table').data('footable'),
			 newRow;

		newRow =	$(
			'<tr><td>' + data.order.from + '</td><td>' + data.order.to + '</td><td>'
			+ data.order.depart.substring(0, 10) + '</td><td>' 
			+ data.order.return.substring(0, 10) + '</td><td>'
			+ data.order.created_at.substring(0, 10) + '</td><td>' 
			+ '<button class="view-order view-order btn btn-primary btn-sm" href="#" data-customer_id="' + data.customer.id 
			+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">View order</button>' + '</td><td>'
			+ '<button class="send-email btn btn-primary btn-sm" href="#" data-customer_id="' + data.customer.id 
			+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">Send email</button>' + '</td><td>'
			+ '<button class="send-ticket btn btn-primary btn-sm" href="#" data-customer_id="' + data.customer.id 
			+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">Send ticket</button>' + '</td><td>'
		);

	   footable.appendRow(newRow);
	});

	// Binding table and filter table event
	$('.footable').bind('footable_breakpoint', function() {

		$('.footable').trigger('footable_expand_first_row');
	}).footable();
	$('#status').change(function (e) {

		e.preventDefault();

		$('.footable').trigger('footable_filter', {
			filter: $('#filter').val()
		});
	});

})(jQuery, window);
