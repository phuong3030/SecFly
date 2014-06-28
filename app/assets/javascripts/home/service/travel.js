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

	// Video Guide
	$('.popup-youtube').magnificPopup({
		disableOn: 700,
		type: 'iframe',
		mainClass: 'mfp-fade',
		removalDelay: 160,
		preloader: false,
      fixedContentPos: false
   });

	// Add new input name by clicking link
	$('.new-adult-ticket').click(function(e) {

		var new_input_field = '<div class="addition-group"><input class="form-control adult-name addition-field" placeholder="Enter name" />'
						+ '<i class="remove-field fa fa-times fa-2x"></i></div>';

		$('.adult-group').append($(new_input_field));

		return false;
	});	
	$('.new-children-ticket').click(function(e) {
	
		var new_input_field = '<div class="addition-group"><input class="form-control children-name addition-field" placeholder="Enter children name" />'
							+ '<i class="remove-field fa fa-times fa-2x"></i></div>';	

		$('.children-group').append($(new_input_field));

		return false;
	});
	$('.new-infant-ticket').click(function(e) {
	
		var new_input_field = '<div class="addition-group"><input class="form-control infant-name addition-field" placeholder="Enter infant name" />'		
							+ '<i class="remove-field fa fa-times fa-2x"></i></div>';		

		$('.infant-group').append($(new_input_field));

		return false;
	});
	// Remove addition field name binding event
	$('.ticket-names').delegate('.remove-field', 'click', function(e) {
		var removeTarget = e.currentTarget.parentNode;

		alertify.confirm('Are you want to delete this info?', function(e) {
			if(e) {

				$(removeTarget).remove();
				alertify.success('Removed successful');
			} else {

				alertify.log('Canceled');
			}
		});
	});

	// Hooking to submit event to validate data
	$('form').submit(function(e) { 

		var i = 0, length,
			 customerName = $('#name'),
		 	 customerEmail = $('#email'),
			 customerPhone = $('#phone'),
			 from = $('#from'),
			 to = $('#to'),
			 depart = $('#depart'),
			 adultName = $('.adult-name'),
			 childrenName = $('.children-name'),
			 infantName = $('.infant-name'),
			 adultNameSum = '',
			 childrenNameSum = '',
			 infantNameSum = '',
			 errors = '';

		// Reset input background color field
		customerName.css({
			'background-color': 'none',
			color: '#555'
		});
		customerEmail.css({
			'background-color': 'none',
			color: '#555'
		});
		customerPhone.css({
			'background-color': 'none',
			color: '#555'
		});
		from.css({
			'background-color': 'none',
			color: '#555'
		});
		to.css({
			'background-color': 'none',
			color: '#555'
		});
		depart.css({
			'background-color': 'none',
			color: '#555'
		});
		adultName[0].style.cssText += 'background-color: none; color: #555;';

		// Validate input
		if (!customerName.val()) {
		
			customerName.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>Customer Name is invalid!</li>';
		}
		if (!customerEmail.val()) {

			customerEmail.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>Email is invalid!</li>';
		}
		if (!(/^\d+$/.test(customerPhone.val()))) {
		
			customerPhone.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>Phone number is invalid!</li>';
		}
		if (!from.val()) {

			from.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>From place is invalid!</li>';
		}
		if (!to.val()) {

			to.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>To place is invalid!</li>';
		}
		if (!depart.val()) {
	
			depart.css({
				'background-color': '#445878',
				color: '#EEEEF7'
			});
			errors = errors + '<li>Depart time is invalid!</li>';
		}

		if (!adultName[0].value && !childrenName[0].value && !infantName[0].value) {
			
			adultName[0].style.cssText += 'background-color: #445878; color: #EEEEF7;';
			errors = errors + '<li>Please enter at least ticket personal name!</li>';
		} else {
			
			adultNameSum = adultNameSum + adultName[0].value;
			childrenNameSum = childrenNameSum + childrenName[0].value;
			infantNameSum = infantNameSum + infantName[0].value;
		}

		for (i = 1, length = adultName.length; i < length; i++) {
			if (!adultName[i].value) {

				errors = errors + "<li>Please don't enter empty adult's name!</li>";
			} else {
				
				adultNameSum = adultNameSum + ';' + adultName[i].value;
			}
		}

		for (i = 1, length = childrenName.length; i < length; i++) {
			if (!childrenName[i].value) {

				errors = errors + "<li>Please don't enter empty children's name!</li>";
			} else {

				childrenNameSum = childrenNameSum + ';' + childrenName[i].value;
			}
		}

		for (i = 1, length = infantName.length; i < length; i++) {
			if (!infantName[i].value) {

				errors = errors + "<li>Please don't enter empty infant's name!</li>";
			} else {

				infantNameSum = infantNameSum + ';' + infantName[i].value;
			}
		}
		
		if (errors) {

			// Display errors to customer
			$('.error-details ol').html(errors);

			return false;
		} else {

			$('#adult_names').val(adultNameSum);
			$('#children_names').val(childrenNameSum);
			$('#infant_names').val(infantNameSum);
		}

	});

}) (jQuery);
