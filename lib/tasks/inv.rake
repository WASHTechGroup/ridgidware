namespace :inv do
=begin
	task :clean => :ennvironment do
		# Get all parts
		parts = Part.all
		# Loop through the part in the
		parts.each do |part|
			puts part.id
			# counting all the ordered 
			all_rec = 0
			all_bor = 0
			all_ord = 0

			# Get all orders that are in for this part
			orders = PartsInOrder.find_all_by({part_id: part.id})
			orders.each do |order|
				puts order.order_id
				all_ord += order.quant_ordered
				all_rec += order.quant_revieved
				all_bor += order.quant_backordered
			end

			# Update the inventory levels
			
		end
	end
=end
end