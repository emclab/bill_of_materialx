// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
   $("#bom_order_date").datepicker({dateFormat: 'yy-mm-dd'});
   $("#bom_receiving_date").datepicker({dateFormat: 'yy-mm-dd'});
   $("#bom_actual_receiving_date").datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
	$("#bom_order_date_s").datepicker({dateFormat: 'yy-mm-dd'});
    $("#bom_receiving_date_s").datepicker({dateFormat: 'yy-mm-dd'});
    $("#bom_actual_receiving_date_s").datepicker({dateFormat: 'yy-mm-dd'});
});