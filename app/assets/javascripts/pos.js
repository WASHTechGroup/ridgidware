function get_total(){
	$.post("/transactions/get_totals.json", {cart_id: "1"}).done(function(data){
		$("#show_total").text(data["total"]);
	});
}


