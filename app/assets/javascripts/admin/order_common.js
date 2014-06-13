(function ($, scope) {

	// Create connection to server and subcribe to special channel
	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.privateChannel = dis.subscribe($('.userinfo h5').html());

	// Listen event from server
	dis.on_open = function(data) { 

		console.log('Connection has been established: ', data); 
	}; 

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

	privateChannel.bind('order_filtered', function(data) {

		var i, length,
			 footable = $('.footable').data('footable'),
			 statusMap = [
				 "NEW",
			 	 "VIEW ORDER",
				 "SENT EMAIL",
				 "SENT TICKETS"
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
						+ data[index].created_at + '</td><td>' 
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

})(jQuery, window);
