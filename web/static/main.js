$(function() {
	var selectBox = $("[name='selectBox']")
	
	
	//initialize
	if(selectBox.val() == 'custom') {
		$("[name='command']").val('');
		$('#custom-row').show();
	} else {
		$("[name='command']").val(selectBox.val());
		$('#custom-row').hide(); 
	}
	
	//selection change
	$("[name='selectBox']").change(function(){
		if(selectBox.val() == 'custom') {
			$("[name='command']").val('');
			$('#custom-row').show(); 
		} else {
			$("[name='command']").val(selectBox.val());
			$('#custom-row').hide(); 
		} 
	});
});


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

watch_enable = false;
watch_job = null;
watch_pins = function(){
	
	if(watch_enable){
		
		clearInterval(watch_job);
		watch_enable = false
		jQuery('.btn-watch').removeClass("btn-danger").addClass("btn-success")
		jQuery('.btn-watch').html("Start Pin Status")
		
	}else{
		
		watch_enable = true		
		jQuery('.btn-watch').removeClass("btn-success").addClass("btn-danger")
	    jQuery('.btn-watch').html("Stop Pin Status")
				
		watch_job = setInterval(function(){ 
			$.getJSON("static/active.json", function(data){		
				jQuery('.pin-status').removeClass("on").addClass("off");
				  $.each( data, function( key, val ) {
					jQuery('.pin-status-' + val).addClass("on").removeClass("off");
				  });
			})	 
		}, 100);	
	}	
}
