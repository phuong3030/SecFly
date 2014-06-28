(function($) { 

	var vnOfficePosition = new google.maps.LatLng(21.0146801, 105.8572626),
		 geOfficePosition = new google.maps.LatLng(52.54953, 13.50654),
	 	 vnMap = new google.maps.Map(
			 $('#vietnam-map')[0],
			 {
				 zoom: 16,
				 center: vnOfficePosition 
			 }
		 ),
		 geMap = new google.maps.Map(
			 $('#germany-map')[0],
			 {
				 zoom: 16,
				 center: geOfficePosition 
			 }
		 ),
		 vnMarker = new google.maps.Marker({
			 position: vnOfficePosition,
			 map: vnMap,
			 title: 'Nacenopto head office'	 	
		 }),
		 geMarker = new google.maps.Marker({
			 position: geOfficePosition,
			 map: geMap,
			 title: 'Nacenopto branch office'	 	
		 });

})(jQuery);
