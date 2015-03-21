$(document).ready(function() {
	var id = parseInt($("input[name='cart_id']").val());
	get_total(id);
});


function get_total(cart_id){
	if(!isNaN(cart_id)) {
		$.post("/transactions/get_totals.json", {cart_id: cart_id}).done(function(data){
			$("#show_total .sizing").text(data["total"]);
		});
	}
}

function switch_cart(add, cart_id, part_id, quant, max) {
	var rcur = parseInt($("#returns .cart table #part_" + part_id+ " .amount").text());
	var ccur = parseInt($("#transaction .cart table #part_" + part_id+ " .amount").text());
	if (max < 1) max = parseInt($("#transaction .cart table #part_" + part_id+ " #max").val());
	// If you are going to add parts to the returns 
	if (add) {
			rcur = rcur - quant;
			ccur = ccur + quant;
			if(rcur < 0) rcur = 0;
			if(ccur > max) ccur = max;
			$.post("/update_part_keep.json", {cart_id: cart_id, part_id: part_id, quantity_requested: rcur}).done(function(){
				$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+rcur+"</b>");
				$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+ccur+"</b>");
			});
	// If you made a mistake and added too many
	} else {
			rcur = rcur + quant;
			ccur = ccur - quant;
			if(ccur < 0) ccur = 0;
			if(rcur > max) rcur = max;
			$.post("/update_part_keep.json", {cart_id: cart_id, part_id: part_id, quantity_requested: rcur}).done(function(){
				$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+rcur+"</b>");
				$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+ccur+"</b>");
			});
	}
}

function checkout(cart_id) {
	calc_change();
	$.post("/transactions/get_totals.json", {cart_id: cart_id}).done(function(data){
		json = {owner: $('#watiam').val(),
				transaction: {
					cart_id: parseInt(cart_id), 
					subtotal: parseFloat(data["subtotal"]), 
					total: parseFloat(data["total"]), 
					tax: parseFloat(data["tax"]), 
					amount_given: parseFloat($("#tendered").val()), 
					change: parseFloat($("#change").text())
				  }
				};
		$.post("/checkout", json).done(function() {
			location.reload(true);
		});
	});
}

function returns(cart_id) {
	calc_change();
	$.post("/transactions/get_totals.json", {cart_id: cart_id}).done(function(data){
		json = {owner: "",
				transaction: {
					cart_id: parseInt(cart_id), 
					subtotal: -1 * parseFloat(data["subtotal"]), 
					total: -1 * parseFloat(data["total"]), 
					tax: -1 * parseFloat(data["tax"]), 
					amount_given: parseFloat(data["total"]), 
					change: 0
				  }
				};
		$.post("/return", json).done(function() {
			location.reload(true);
		});
	});
}

function calc_change(){
	total = parseFloat($("#show_total").text());
	console.log(total.toFixed(2))
	tenderd =  parseFloat($("#tendered").val());
	console.log(tenderd.toFixed(2));
	change = tenderd - total;
	console.log(change.toFixed(2))
	$('#change').text(change.toFixed(2));
}

function get_trans_cart() {
	var id = $("#transaction_id").val();
	if (id != null) {
		window.location="/pos/returns?transaction_id="+id;
	}
}

