(function ($, scope) {

	// Subcribe to special channel
	scope.orderEmp = dis.subscribe('orders_management_emp');

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
  $('.preview-email-content').on('click', '#send-email', function(e) {

    alertify.confirm("Do you want to send email to customer?", function (e) {

      if (e) {

        var data = { 
          order_id: $('.email_order_id').text()
        };

        window.dis.trigger('send_email', data); 
      }
      else {
        alertify.error("Cancel action send email!", "", 0);
      }
    });
  });
	$('tbody').on('click', '.send-ticket', function(e) {
		
		var data = { 
			order_id: e.currentTarget.getAttribute('data-order_id')
		};

		alertify.confirm("Has customer already get tickets? System will delete this row.", function (e) {
			if (e) {
				window.dis.trigger('send_ticket', data);
			} else {
				alertify.error("Cancel action send tickets!", "", 0);
			}
		});

		return false;
	});

	// Listen event from server
	privateChannel.bind('order_customer_preview_email', function (data) {
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
		$('.email_order_created_at').html(new Date(order.created_at).toLocaleString());
		$('.email_from').html(order.from);
		$('.email_to').html(order.to);
		$('.email_depart').html(order.depart_date);
		$('.email_return').html(order.return_date);

		$.magnificPopup.open({
			items: {
				src: ".preview-email-wrap",
				type: "inline"
			}
		});

	});

	privateChannel.bind('order_customer_send_email', function (data) {

		alertify.success("Send email successful!");
	});

	privateChannel.bind('order_customer_send_tickets', function (data) {

		alertify.success("Send tickets successful!");
	});

	// Listen event by another employee
	orderEmp.bind('order_other_emp_view_order', function(data) {

		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status viewed').html('VIEWED');	
	});
	orderEmp.bind('order_other_emp_send_email', function(data) {
	
		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status sent-email').html('SENT EMAIL');	
	});
	orderEmp.bind('order_other_emp_send_ticket', function(data) {
	
		var statusColumn = $('.order_id_' + data.id + ' .order_status');

		statusColumn.removeClass().addClass('order_status sent-tickets').html('SENT TICKETS');	
	});

	// Listen event new request ticket by customer
	orderEmp.bind('new_request', function (data) {
	
		var footable = $('table').data('footable'),
			 newRow,
			 statusMap = [
				 "<span class='order_status new'>NEW</span>",
			 	 "<span class='order_status view-order'>VIEW ORDER</span>",
				 "<span class='order_status sent-email'>SENT EMAIL</span>",
				 "<span class='order_status sent-tickets'>SENT TICKETS</span>"
			 ];		
	
		newRow =	$(
			'<tr><td>' + data.order.from + '</td><td>' 
			+ data.order.to + '</td><td>'
			+ data.order.depart_date + '</td><td>' 
			+ (data.order.return_date || '&nbsp;') + '</td><td>'
			+ new Date(data.order.created_at).toLocaleString() + '</td><td>' 
			+ statusMap[data.order.status] + '</td><td>' 
			+ '<button class="view-order view-order btn btn-primary btn-sm"' 
			+ 'href="#" data-order_id="' 
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
