
edit_add_pin = function(pin = "new"){
	
	$.get( "edit?id=" + pin, function( data ) {
		$( "#get_modal .modal-body" ).html( data );
		$( "#get_modal").modal('show');
	});
	
}

get_modal_save = function(){

	var i = $(this).prev('form');
	alert($(i).attr('action'))
	
	
}