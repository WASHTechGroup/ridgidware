$(document).ready(function() {
	var id = parseInt($("input[name='cart_id']").val());
	get_total(id);
});


function get_total(cart_id){
	$.post("/transactions/get_totals.json", {cart_id: cart_id}).done(function(data){
		$("#show_total .sizing").text(data["total"]);
	});
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

function calc_change(){
	total = parseFloat($("#show_total").text());
	console.log(total.toFixed(2))
	tenderd =  parseFloat($("#tendered").val());
	console.log(tenderd.toFixed(2));
	change = tenderd - total;
	console.log(change.toFixed(2))
	$('#change').text(change.toFixed(2));
}

