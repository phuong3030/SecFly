(function ($, scope) {

	// Subcribe to special channel
	scope.order_emp = dis.subscribe('orders_management_emp');

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

		alertify.confirm("Has customer already get tickets? System will delete this row.", function (e) {
			if (e) {
				window.dis.trigger('send_ticket', data);
				alertify.success("Send tickets successful!");
			} else {
				alertify.error("Cancel action send tickets!", "", 0);
			}
		});

		return false;
	});

	// Listen event from server
	order_emp.bind('order_detail', function (data) {

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

	order_emp.bind('order_customer_preview_email', function (data) {
		var order = data.order,
			 customer = data.customer,
			 adult = '',
			 children = '',
			 infant = '';

		adult = order.adult_names.split(';').map(function(e) { 
			return '<p> Mr(s) ' + e + '</p>'; 
		}).join('');

		if (order.children_names !== '') {

			children = order.children_names.split(';').map(function(e) {

				return "<p> Child's name: " + e + '</p>'; 
			}).join('');
		}
		if (order.infant_names !== '') {

			infant = order.infant_names.split(';').map(function(e) {

				return "<p> Infant's name: " + e + '</p>'; 
			}).join('');
		}

		$('.email_order_id').html(order.id);
		$('.email_customer_name').html(adult + children + infant);
		$('.email_order_created_at').html(order.created_at);
		$('.email_from').html(order.from);
		$('.email_to').html(order.to);
		$('.email_depart').html(order.depart_date);
		$('.email_return').html(order.return_date);

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

	order_emp.bind('order_customer_send_email', function (data) {

		console.log(data);
	});

	order_emp.bind('order_customer_tickets', function (data) {

		console.log(data);
	});

	order_emp.bind('new_request', function (data) {
	
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

})(jQuery, window);
