(function ($) {
	
	var placeTitle = $(".place-title>h2"),
		 fromInputField = $("#from"),
		 toInputField = $("#to");

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
	$('#depart').datepicker({
		minDate: new Date(),
		dateFormat: 'dd/mm/yy'
	});
	$('#return').datepicker({
		minDate: new Date(),
		dateFormat: 'dd/mm/yy'
	});

}) (jQuery);
