(function ($, scope) {

	scope.dis = new WebSocketRails(scope.location.host + '/websocket');
	scope.channel = dis.subscribe('orders_management_man');

	dis.on_open = function(data) { 
		console.log('Connection has been established: ', data); 
	}; 

	channel.bind('view_order', function(data) {
	
		console.log(data);
		
		$('tbody').append($('<tr><td> ' + data.user 
				+ '</td><td>VIEW ORDER</td><td>' + data.customer_id 
				+ '</td><td> ' + data.from + ' => ' + data.to + '</td><td>' + data.time
				+ '</td></tr>'));
	});
	channel.bind('send_email', function(data) {
	
		console.log(data);
		$('tbody').append($('<tr><td> ' + data.user 
				+ '</td><td>SEND EMAIL</td><td>' + data.customer_id 
				+ '</td><td> ' + data.from + ' => ' + data.to + '</td><td>' + data.time
				+ '</td></tr>'));
	});
	channel.bind('send_ticket', function(data) {
	
		console.log(data);
		$('tbody').append($('<tr><td> ' + data.user 
				+ '</td><td>SEND TICKET</td><td>' + data.customer_id 
				+ '</td><td> ' + data.from + ' => ' + data.to + '</td><td>' + data.time
				+ '</td></tr>'));

	});

})(jQuery, window);
