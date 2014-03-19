$(function(){
	$("#date_range").change(function(){
		method = $(".data-table").data("method");
		date_range=  $(this).val();
		meter_id = $(".data-table").data("id");
		window.location.href = "/meters/"+meter_id+"/"+method+"?date_range="+date_range
	});
})