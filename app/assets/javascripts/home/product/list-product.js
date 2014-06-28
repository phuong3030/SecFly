(function ($) {

	$('select').change(function(e) {

		var page = $('.pagination li.active a').html(),
			 categoryName = $('#_category_id').val(),
			 numberOfItem = $('#_number_of_item').val(),
			 url = window.location.origin + window.location.pathname;

		if (e.currentTarget.id === '_number_of_item') {
			
			page = 1;
		}
		if (page && page !== '') { 

			url = url + '?page=' + page;
		}
		if (categoryName && categoryName !== '') {
			
			if (url.indexOf('?') > -1) { 

				url = url + '&_category_id=' + categoryName;
			} else {

				url = url + '?_category_id=' + categoryName;
			}
		}
		if (numberOfItem && numberOfItem !== '') {

			if (url.indexOf('?') > -1) { 

				url = url + '&_number_of_item=' + numberOfItem;
			} else {

				url = url + '?_number_of_item=' + numberOfItem;
			}
		}

		window.location.href = url;
	});

})(jQuery);
