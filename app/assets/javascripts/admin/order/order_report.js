//= require jquery-ui-custom

(function($, scope) { 

	// Datetime picker event binding
	$('#start').datepicker({
		dateFormat: 'dd/mm/yy'
	});
	$('#end').datepicker({
		dateFormat: 'dd/mm/yy'
	});

	$('.export-report').click(function(e) {
		var host = scope.location.origin + scope.location.pathname,
			 start_time = $('#start').val(),
			 end_time = $('#end').val(),
			 emp_id = $('#_employee').val();
		
		window.location.href = host + 
									'.xlsx?&start=' + start_time +
									'&end=' + end_time +
									'&employee=' + emp_id;
		return false;
	});

})(jQuery, window);
