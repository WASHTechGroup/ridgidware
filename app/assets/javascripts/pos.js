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
	var rcur = 0;
	var ccur = 0;
	$.get("parts/"+part_id+".json").done(function(data) {
		// The HTML for the cart 
		html_remove = "<tr class = 'borders fit' id='part_"+ part_id + "'>" +
						"<td id='c5'><button type='button' class = 'btn-default btn-s' id = 'small' onclick = 'switch_cart(false, "+ cart_id +","+ part_id +", "+ max +", "+ max +")'>X</button></td>" + 
						"<td id='c6'>" + data["part_number"] + "</td>" +
						"<td id='c6'>" + data["price"] + "</td>" +
						"<td id='c8'>" + data["description"] + "</td>" +
						"<td class='amount' id='c10'><b>" + quant + "</b></td>" + 
						"<td id='c11'><button type=button' class = 'btn-default btn-xs' onclick='switch_cart(false, "+ cart_id +","+ part_id +", 1, "+ max +")'>-</button></td>" +						
				   "</tr>";
		html_add = "<tr class = 'borders fit' id='part_"+ part_id + "'>" +
						"<td id='c5'><button type='button' class = 'btn-default btn-s' id = 'small' onclick = 'switch_cart(true, "+ cart_id +","+ part_id +", "+ max +", "+ max +")'>X</button></td>" + 
						"<td id='c6'>" + data["part_number"] + "</td>" +
						"<td id='c6'>" + data["price"] + "</td>" +
						"<td id='c8'>" + data["description"] + "</td>" +
						"<td class='amount' id='c10'><b>" + quant + "</b></td>" + 
						"<td id='c11'><button type=button' class = 'btn-default btn-xs' onclick='switch_cart(true, "+ cart_id +","+ part_id +", 1, "+ max +")'>-</button></td>" +						
				   "</tr>";
		// If you are going to add parts to the returns 
		if(add) {
			// Check if the part is already in the cart
			if($("#returns .cart table #part_" + part_id).length) {
				// Get the amount being returned
				rcur = $("#returns .cart table #part_" + part_id + " .amount").text();
				ccur = $("#transaction .cart table #part_" + part_id + " .amount").text();
				// Check if the quantity is not too big
				if (max >= quant) {
					// Get amount and ensure it is less than the amount the person owns
					amount = parseInt(rcur) + quant;
					if(amount > max) amount = max;
					console.log(amount);
					// Update the return cart 
					$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
						$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+amount+"</b>");
						$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+(ccur - amount)+"</b>");
						get_total(cart_id);
					});
				}
			// If it isnt thaere then add it and change values
			} else {
				$.post("add_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data){
					// add the new entry to the carts
					$(".cart table tr:last").after("" + html_add);
					// Get the amount being returned
					rcur = $("#returns .cart table #part_" + part_id + " .amount").text();
					ccur = $("#transaction .cart table #part_" + part_id + " .amount").text();
					// Check if the quantity is not too big
					if (max >= quant) {
						// Get amount and ensure it is less than the amount the person owns
						amount = parseInt(rcur) + quant;
						if(amount > max) amount = max;
						console.log(amount);
						// Update the return cart 
						$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
							$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+amount+"</b>");
							$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+(ccur - amount)+"</b>");
							get_total(cart_id);
						});
					}
				});

			}
		// If you made a mistake and added too many
		} else {
			// Check if the part is already in the cart
			if($("#returns .cart table #part_" + part_id).length) {
				// Get the amount being returned
				rcur = $("#returns .cart table #part_" + part_id + " .amount").text();
				ccur = $("#transaction .cart table #part_" + part_id + " .amount").text();
				// Check if the quantity is not too big
				if (max >= quant) {
					// Get amount and ensure it is less than the amount the person owns
					amount = parseInt(ccur) - quant;
					if(amount > max) amount = max;
					console.log(amount);
					// Update the return cart 
					$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
						$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+amount+"</b>");
						$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+(ccur - amount)+"</b>");
						get_total(cart_id);
					});
				}
			// If it isnt thaere then add it and change values
			} else {
				$.post("add_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data){
					// add the new entry to the carts
					$(".cart table tr:last").after("" + html_add);
					// Get the amount being returned
					rcur = $("#returns .cart table #part_" + part_id + " .amount").text();
					ccur = $("#transaction .cart table #part_" + part_id + " .amount").text();
					// Check if the quantity is not too big
					if (max >= quant) {
						// Get amount and ensure it is less than the amount the person owns
						amount = parseInt(rcur) + quant;
						if(amount > max) amount = max;
						console.log(amount);
						// Update the return cart 
						$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
							$("#returns .cart table #part_" + part_id + " .amount").html("<b>"+amount+"</b>");
							$("#transaction .cart table #part_" + part_id + " .amount").html("<b>"+(ccur - amount)+"</b>");
							get_total(cart_id);
						});
					}
				});

			}
		}
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
	window.location="/pos/returns?transaction_id="+id;
}

