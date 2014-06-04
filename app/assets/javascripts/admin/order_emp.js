(function ($, scope) {

	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.channel = dis.subscribe('orders_management_emp');

	channel.bind('new_request', function (data) {
	
		console.log(data);
		//get the footable object
		var footable = $('table').data('footable'),
			 newRow;

		newRow =	$(
			'<tr><td>' + data.order.from + '</td><td>' + data.order.to + '</td><td>'
			+ data.order.depart.substring(0, 10) + '</td><td>' + data.order.return.substring(0, 10) + '</td><td>'
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

	dis.on_open = function(data) {

		console.log('Connection has been established: ', data);
	}

	$('tbody').on('click', '.view-order', function(e) {

		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html()
		};

		window.dis.trigger('view_order', data);
		
		return false;
	});
	$('tbody').on('click', '.send-email', function(e) {

		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html()
		};

		window.dis.trigger('send_email', data);
		
		return false;
	});
	$('tbody').on('click', '.send-ticket', function(e) {
		
		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html()
		};

		window.dis.trigger('send_ticket', data);

		return false;
	});
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
