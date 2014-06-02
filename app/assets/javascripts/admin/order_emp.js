(function ($, scope) {

	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.channel = dis.subscribe('orders_management_emp');

	channel.bind('new_request', function (data) {
	
		console.log(data);
		$('tbody').append(
			$('<tr><td>' + data.customer.id + '</td><td>'
				+ data.order.from + '</td><td>' + data.order.to + '</td><td>'
				+ data.order.depart.substring(0, 10) + '</td><td>' + data.order.return.substring(0, 10) + '</td><td>'
				+ data.order.adult + '</td><td>' + data.order.children + '</td><td>'
				+ data.order.created_at.substring(0, 10) + '</td><td>' 
				+ '<a class="view-order" href="#" data-customer_id="' + data.customer.id 
				+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">View order</a>' + '</td><td>'
				+ '<a class="send-email" href="#" data-customer_id="' + data.customer.id 
				+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">Send email</a>' + '</td><td>'
				+ '<a class="send-ticket" href="#" data-customer_id="' + data.customer.id 
				+ '" data-from="' + data.order.from + '" data-to="' + data.order.to + '">Send ticket</a>' + '</td><td>'
			 ));

	});

	dis.on_open = function(data) {

		console.log('Connection has been established: ', data);
	}

	$('tbody').on('click', '.view-order', function(e) {

		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html(),
			time: new Date()
		};

		window.dis.trigger('view_order', data);
		
		return false;
	});
	$('tbody').on('click', '.send-email', function(e) {

		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html(),
			time: new Date()
		};

		window.dis.trigger('send_email', data);
		
		return false;
	});
	$('tbody').on('click', '.send-ticket', function(e) {
		
		var data = { 
			customer_id: e.currentTarget.getAttribute('data-customer_id'),
			from: e.currentTarget.getAttribute('data-from'),
			to: e.currentTarget.getAttribute('data-to'),
			user: $('.userinfo>h5').html(),
			time: new Date()
		};

		window.dis.trigger('send_ticket', data);

		return false;
	});

})(jQuery, window);
