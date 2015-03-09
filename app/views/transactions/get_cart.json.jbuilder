json.parts(@parts_in_cart) do |part|
	json.part_id part.part_id
	json.amount part.amount_requested
end