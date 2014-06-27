(function ($, scope) {

	// Create connection to server and subcribe to special channel
	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.privateChannel = dis.subscribe($('.userinfo h5').html());

	// Listen event from server
	dis.on_open = function(data) { 

		console.log('Connection has been established: ', data); 
	}; 

	privateChannel.bind('order_detail', function (data) {

		var adult_tickets = data.order.adult_names !== '' ? data.order.adult_names.split(';') : [],
			 children_tickets = data.order.children_names !== '' ? data.order.children_names.split(';') : [],
			 infant_tickets = data.order.infant_names !== '' ? data.order.infant_names.split(';') : [],
			 time_slot_map = ['Morning', 'Mid day', 'Afternoon', 'Evening'],
			 payment_method = ['By money at office', 'By credit card'];

		$('.customer_id').html(data.customer.id);
		$('.customer_group').html(data.customer.group_id);
		$('.customer_name').html(data.customer.name);
		$('.customer_phone').html(data.customer.phone);
		$('.customer_email').html(data.customer.email);

		$('.order_from').html(data.order.from);
		$('.order_to').html(data.order.to);
		$('.order_depart').html(data.order.depart_date + ' - ' + time_slot_map[data.order.depart_time_slot]);
		$('.order_return').html((data.order.return_date + ' - ' + time_slot_map[data.order.return_time_slot]) || '&nbsp;');
		$('.payment_method').html(payment_method[data.order.payment_method]);
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

	privateChannel.bind('order_filtered', function(data) {

		var i, length,
			 footable = $('.footable').data('footable'),
			 statusMap = [
				 "<span class='order_status new'>NEW</span>",
			 	 "<span class='order_status view-order'>VIEW ORDER</span>",
				 "<span class='order_status sent-email'>SENT EMAIL</span>",
				 "<span class='order_status sent-tickets'>SENT TICKETS</span>"
			 ];

		// Remove all row in table
		$('.footable tbody tr').remove();

		// Add new data to table
		for (i = 0, length = data.length; i < length; i++) {
			(function (index) {
				var newRow = $(
						'<tr><td>' + data[index].from 
						+ '</td><td>' + data[index].to + '</td><td>'
						+ data[index].depart_date + '</td><td>' 
						+ (data[index].return_date || '&nbsp;') + '</td><td>'
						+ new Date(data[index].created_at).toLocaleString() + '</td><td>' 
						+ statusMap[data[index].status] + '</td><td>' 
						+ '<button class="view-order view-order btn btn-primary btn-sm"' 
						+ 'href="#" data-order_id="' 
						+ data[index].id + '">View order</button>' + '</td><td>'
						+ '<button class="send-email btn btn-primary btn-sm"'
						+ 'href="#" data-order_id="' 
						+ data[index].id + '">Send email</button>' + '</td><td>'
						+ '<button class="send-ticket btn btn-primary btn-sm"' 
						+ 'href="#" data-order_id="' 
						+ data[index].id + '">Send ticket</button>' + '</td><td>'
				);

				footable.appendRow(newRow);
			})(i);
		}
	});

	// Datetime picker event binding
	$('#start').datepicker({
		dateFormat: 'dd/mm/yy'
	});
	$('#end').datepicker({
		dateFormat: 'dd/mm/yy'
	});

	$('.get-data').click(function(e) {
		var start_time = $('#start').val(),
			 end_time = $('#end').val(),
			 status = $('#status').val();

		window.dis.trigger(
			'get_filtered_order_data', 
			{ 
				start_time: start_time === '' ? null : start_time,
				end_time: end_time === '' ? null : end_time,
				status: status === '' ? null : status
			}
		);
	});

})(jQuery, window);
