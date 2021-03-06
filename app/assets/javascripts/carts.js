// Add part to the cart form
function add_to_cart(cart_id, part_id) {
	// Add the item to the cart
	
	// Make a get call to get the part data as a json
	$.get("parts/"+part_id+".json").done(function(data) {
		// Variables
		var cur = "";
		var max_inv = parseInt(data["on_hand"]);
		// Let's make sure there is inventory
		if (max_inv > 0) {
			// create the HTML of the table entry
			html = "<tr class = 'borders fit' id='part_"+ part_id + "'>" +
						"<td id='c5'><button type='button' class = 'btn-default btn-s' id = 'small' onclick = 'delete_item("+ cart_id +","+ part_id +")'>X</button></td>" + 
						"<td id='c6'>" + data["part_number"] + "</td>" +
						"<td id='c6'>" + data["price"] + "</td>" +
						"<td id='c8'>" + data["description"] + "</td>" +
						"<td id='c9'><button type=button' class = 'btn-default btn-xs' onclick='add_to_cart("+ cart_id +","+ part_id +")'>+</button></td>" +	
						"<td class='amount' id='c10'><a href='#basicModal' role='button' class='btn-default btn-s' data-toggle='modal' onclick='call_modal("+ part_id +")'><b>1</a></b></td>" + 
						"<td id='c11'><button type=button' class = 'btn-default btn-xs' onclick='remove_from_cart("+ cart_id +","+ part_id +")'>-</button></td>" +	
				   "</tr>";
			// If the entry is in the cart
			if($(".cart table #part_" + part_id).length) {
				// update the count of the part
				cur = $(".cart table #part_" + part_id + " .amount").text();
				if (max_inv > cur) {
					amount = parseInt(cur) + 1;
					console.log(amount);
					$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
						$(".cart table #part_" + part_id + " .amount").html("<a href='#basicModal' role='button' class='btn-default btn-s' data-toggle='modal'><b>"+amount+"</a></b>");
						get_total(cart_id);
					});
				}
			}
			// If it is not in the cart 
			else {
				$.post("add_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data){
					// add the new entry to the carts
					$(".cart table tr:last").after("" + html);
					get_total(cart_id);
				});
			}
		}
	});
	get_total(cart_id);
	
}

// Remove a part entry from the cart
function remove_from_cart(cart_id, part_id) {
	var cur = "";
	var amount = 0;
	// Check if the entry is in the cart
	if($(".cart table #part_" + part_id).length) {
		// If it is in the cart ger the current amount
		cur = $(".cart table #part_" + part_id + " .amount").text();
		amount = parseInt(cur) - 1;
		console.log("Value: " +  amount);
		// If the current amount is more than 1
		if(amount != 0) {
			$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
				$(".cart table #part_" + part_id + " .amount").html("<a href='#basicModal' role='button' class='btn-default btn-s' data-toggle='modal'><b>"+amount+"</a></b>");
				get_total(cart_id);
			});
		} else {
			console.log("Remove");
			$.post("remove_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data) {
				$(".cart table #part_" + part_id).remove();	
				get_total(cart_id);
			});
			
		}
	}
	get_total(cart_id);
}

function delete_item(cart_id, part_id){
	$.post("remove_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data) {
		$(".cart table #part_" + part_id).remove();	
		get_total(cart_id);
	});
	get_total(cart_id);
}

function add_quantity_manually(cart_id){
	var part=$("#basicModal #part_id").val();
	var quant=$("#basicModal #quantity").val();
	part = parseInt(part);
	quant = parseInt(quant);
	console.log(part);
	console.log(quant);
	if (quant <0 || quant > 100) //change to quantity in inventory
	{
		alert("Invalid quantity. Please try again.");
	}
	else
	{
		$.post("update_part.json", {cart_id: cart_id, part_id: part, quantity_requested: quant}).done(function(){
				$(".cart table #part_" + part + " .amount").html("<a href='#basicModal' role='button' class='btn-default btn-s' data-toggle='modal'><b>"+quant+"</a></b>");
				location.reload();
				get_total(cart_id);
			});
	}
	get_total(cart_id);
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
			get_total(cart_id);
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
			get_total(cart_id);
	}
	get_total(cart_id);
}

function call_modal(part_id){
	$("#basicModal #part_id").val(part_id);
}
