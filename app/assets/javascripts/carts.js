// Add part to the cart form
function add_to_cart(cart_id, part_id) {
	// Add the item to the cart
	
	// Make a get call to get the part data as a json
	$.get("parts/"+part_id+".json").done(function(data) {
		// Variables
		var cur = "";
		// create the HTML of the table entry
		html = "<tr class = 'borders' id='part_"+ part_id + "'>" +
					"<td>" + data["part_number"] + "</td>" +
					"<td>photo</td>" +
					"<td>" + data["description"] + "</td>" +
					"<td><button type=button' class = 'btn-default btn-xs' onclick='add_to_cart("+ cart_id +","+ part_id +")'>+</button></td>" +	
					"<td class='amount'><button type='button' class='button-default btn-xs' data-toggle='#basicModal' data-target='modal'><b>1</b></td>" +
					"<td><button type=button' class = 'btn-default btn-xs' onclick='remove_from_cart("+ cart_id +","+ part_id +")'>-</button></td>" +	
			   "</tr>";
		// If the entry is in the cart
		if($(".cart table #part_" + part_id).length) {
			// update the count of the part
			cur = $(".cart table #part_" + part_id + " .amount").text();
			amount = parseInt(cur) + 1;
			console.log(amount);
			$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
				$(".cart table #part_" + part_id + " .amount").html("<a href='#basicModal' role='button' class='btn' data-toggle='modal'><b>"+amount+"</a></b>");
				get_total(cart_id);
			});
		}
		// If it is not in the cart 
		else {
			$.post("add_part.json", {cart_id: cart_id, part_id:part_id}).done(function(data){
				// add the new entry to the carts
				$(".cart table tr:last").after("" + html);
				get_total(cart_id);
			});
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
		console.log("Value: " +  amount)
		// If the current amount is more than 1
		if(amount != 0) {
			$.post("update_part.json", {cart_id: cart_id, part_id: part_id, quantity_requested: amount}).done(function(){
				$(".cart table #part_" + part_id + " .amount").html("<a href='#basicModal' role='button' class='btn' data-toggle='modal'><b>"+amount+"</a></b>");
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
			});
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
				$(".cart table #part_" + part + " .amount").html("<a href='#basicModal' role='button' class='btn' data-toggle='modal'><b>"+quant+"</a></b>");
				get_total(cart_id);
			});
	}
}

function call_modal(part_id){
	$("#basicModal #part_id").val(part_id);
}