(function ($) {
	
	var placeTitle = $(".place-title>h2"),
		 fromInputField = $("#from"),
		 toInputField = $("#to");

	// Show pop event binding and send data to input field
	$("#from").magnificPopup({
		items: {
			src: "#place-popup",
			type: "inline"
		},
		callbacks: {
			beforeOpen: function() {
				placeTitle.html("From");
			}
		}
	});
	$("#to").magnificPopup({
		items: {
			src: "#place-popup",
			type: "inline"
		},
		callbacks: {
			beforeOpen: function() {
				placeTitle.html("To");
			}
		}
	});
	$("#place-popup").delegate(".airport-name", "click", function(e) {
		$.magnificPopup.close();
			
		if (placeTitle.html() === "From") {

			fromInputField.val(e.currentTarget.innerHTML);	
		} else if (placeTitle.html() === "To") { 

			toInputField.val(e.currentTarget.innerHTML);	
		}

		return false;
	});
	// datetime picker event binding
	$('#depart').datepicker({
		minDate: new Date(),
		dateFormat: 'dd/mm/yy'
	});
	$('#return').datepicker({
		minDate: new Date(),
		dateFormat: 'dd/mm/yy'
	});
	// Add new input name by clicking link
	$('.new-adult-ticket').click(function(e) {

		var new_input_field = '<input class="form-control adult-name" placeholder="Enter name" />'		

		$('.adult-group').append($(new_input_field));

		return false;
	});	
	$('.new-children-ticket').click(function(e) {
	
		var new_input_field = '<input class="form-control children-name" placeholder="Enter children name" />'		

		$('.children-group').append($(new_input_field));

		return false;
	});
	$('.new-infant-ticket').click(function(e) {
	
		var new_input_field = '<input class="form-control infant-name" placeholder="Enter infant name" />'		

		$('.infant-group').append($(new_input_field));

		return false;
	});
}) (jQuery);
