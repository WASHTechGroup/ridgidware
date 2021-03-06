$(document).ready(function() {
	var id = $("input[name='cart_id']").val();
	get_total(id);

	var url = window.location.href; 
	if (url.indexOf("#co_success") > -1) {
		show_notice("checkout successful", "success");
	}
});


function get_total(cart_id){
	if(!isNaN(cart_id)) {
		$.post("/transactions/get_totals.json", {cart_id: cart_id}).done(function(data){
			$("#show_total .sizing").text(data["total"]);
		});
	}
}

function checkout(cart_id) {
	calc_change();
	var change = parseFloat($('#change').text());
	$.post("/item_count.json", {cart_id: cart_id}).done(function(data) {
		if (parseInt(data["count"]) > 0) {	
			if (change > 0) {
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
					$.post("/checkout.json", json).done(function(data) {
						var url = "http://" + window.location.host + "/pos/recipt/"+data["id"]+".pdf" 
						window.open(url)
						window.location =  "/pos#co_success";
						location.reload(true)
					});
				});
			
			} else {
				show_notice("The amount tendered is less than the total needed", "danger");
			}
		} else {
			show_notice("The Cart is empty", "danger");
		}
	});
}

function returns(cart_id) {
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
			// location.reload(true);
			window.location="/pos";
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

function remove_flash(link) {
	var url = window.location.href;
	if (url.indexOf("#co_success") > -1) {
		window.location =  "/pos";
	}
	$(link).remove();
}

function show_notice(message, type) {
	html = "<div id='item' class='alert alert-" + type + "' onclick='remove_flash(this)'>"+ message +"</div>"
	$('#flash').append(html);
	// setTimeout( "$('#alert #item').remove();",10000);
}

