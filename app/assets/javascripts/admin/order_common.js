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

		console.log(data);	
	});

})(jQuery, window);
