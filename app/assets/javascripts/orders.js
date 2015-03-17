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

// JS to update the values in orders
function update_values() {
	// Get the values from the modal
	var pid = parseInt($("#basicModal #part_id").val());
	var oid = parseInt($("#basicModal #order_id").val());
	var ord = parseInt($("#basicModal #quant_ordered").val());
	var bko = parseInt($("#basicModal #quant_backordered").val());
	var rec = parseInt($("#basicModal #quant_received").val());
	// Check if the amount make sense
	if(rec + bko <= ord) {
		$.post("/update_values.json", {part_id: pid, order_id: oid, quant_received: rec, quant_backordered: bko}).done(function() {
			location.reload();
		});
	} else {
		alert("The total does not match what is ordered");
	}
}

// Set the values in the Modal
function set_modal(link) {
	// Variable 
	var ord = $(link).parent().parent().find('.ordered').text();
	var rec = $(link).parent().parent().find('.received').text();
	var bko = $(link).parent().parent().find('.backordered').text();
	var pid = $(link).parent().parent().find('.part_id').val();
	var oid = $(link).parent().parent().find('.order_id').val();

	// Update 
	$("#basicModal #part_id").val(pid);
	$("#basicModal #order_id").val(oid);
	$("#basicModal #quant_ordered").val(ord);
	$("#basicModal #quant_backordered").val(bko);
	$("#basicModal #quant_received").val(rec);
}