// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('.dropdown').on('show.bs.dropdown', function (e) {
	            $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
	                    });

        // ADD SLIDEUP ANIMATION TO DROPDOWN //
 $('.dropdown').on('hide.bs.dropdown', function (e) {
                    $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
                             });
