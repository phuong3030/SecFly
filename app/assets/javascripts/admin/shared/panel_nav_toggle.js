(function($){
	
	$('.cms-panel-navigation .dropdown > a').click(function(e){

		var toggleMenu = e.currentTarget.parentElement.getElementsByTagName('ul')[0];

		$(toggleMenu).slideToggle(400);

		return false;
	});	

})(jQuery);
