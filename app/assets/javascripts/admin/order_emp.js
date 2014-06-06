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
	$('tbody').on('click', '.preview-email', function(e) {

		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		window.dis.trigger('preview_email', data);
		
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

	channel.bind('order_customer_preview_email', function (data) {

		$('.email_order_id').html(data.id);
		$('.email_order_created_at').html(data.created_at);
		$('.email_from').html(data.from);
		$('.email_to').html(data.to);
		$('.email_depart').html(data.depart);
		$('.email_return').html(data.return);
		$('.email_quantity').html(
			data.children + ' children ticket(s), ' 
			+ data.adult + ' adult ticket(s), ' 
			+ data.seniors + ' senior ticket(s) '
		);

		$.magnificPopup.open({
			items: {
				src: ".preview-email-wrap",
				type: "inline"
			},
			callbacks: {
				beforeClose: function() {
				}
			}
		});

	});

	channel.bind('order_customer_send_email', function (data) {

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
			+ data.order.depart + '</td><td>' 
			+ data.order.return + '</td><td>'
			+ data.order.created_at + '</td><td>' 
			+ '<button class="view-order view-order btn btn-primary btn-sm" href="#" data-order_id="' 
			+ data.order.id + '">View order</button>' + '</td><td>'
			+ '<button class="send-email btn btn-primary btn-sm" href="#" data-order_id="' 
			+ data.order.id + '">Send email</button>' + '</td><td>'
			+ '<button class="send-ticket btn btn-primary btn-sm" href="#" data-order_id="' 
			+ data.order.id + '">Send ticket</button>' + '</td><td>'
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
