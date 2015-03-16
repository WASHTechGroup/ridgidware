// JS to remove the field
function remove_fields(link) {
  var o_id = $("input[name='order_id']").val();
	var p_id = $(link).siblings('.part_select').find('option:selected').val()
	$.post("/remove_item.json", {part_id: p_id, order_id: o_id}).done(function() {
		$(link).closest('.fields').remove();
	});
}

// JS to add the field to orders list 
function add_fields(link) {
  var time = new Date().getTime();
  var regexp = new RegExp($(link).data('id'), 'g');
  $(link).before($(link).data('fields').replace(regexp, time))
}

function remove_item(part_id, order_id) {
	$.post("/remove_item.json", {part_id: part_id, order_id: order_id})
}

$(".add_fields").click(function(){
	var time = new Date().getTime();
	var regexp = new RegExp($(this).data('id'), 'g');
	$(this).before($(this).data('fields').replace(regexp, time))
	event.preventDefault();	
});

$(".remove_fields").click(function(){
	var o_id = $("input[name='order_id']").val();
	var p_id = $(this).closest('select option:selected').val();
	if(o_id != null && p_id != null) {
		remove_item(p_id, o_id);
	}
	$(this).closest('.fields').remove();
	event.preventDefault();	
});