

jQuery(document).ready(function(){
	$("select").initialize( function(){
		$(this).selectpicker();
	})
});


edit_add_pin = function(pin = "new"){
	
	$.get( "edit?id=" + pin, function( data ) {
		$( "#get_modal .modal-body" ).html( data );
		
		$( "#get_modal").modal('show');
	});
		
}
