(function ($) {

	$("#dtBox").DateTimePicker({});
	$("#from").magnificPopup({
		items: {
			src: "#place-popup",
			type: "inline"
		}	
	});
	$("#to").magnificPopup({
		items: {
			src: "#place-popup",
			type: "inline"
		}
	});

}) (jQuery);
