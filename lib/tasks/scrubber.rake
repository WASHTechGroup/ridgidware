namespace :scrubber do
	require "nokogiri"
	require "open-uri"
	url = "http://search.digikey.com/scripts/DkSearch/dksus.dll?Detail&name="
	desc "A task to scrub the prices form the api"
	task :costs => :environment do
		# get all part numbers 
		page_no = Part.pluck(:part_number)
		# for all part numbers in the db
		page_no.each do |no|
			puts "#{url}#{no}" 
			# get the HTML of the page 
			page =  Nokogiri::HTML(open("#{url}#{no}"))
			# Get the headers and body of the pricing table
			headers = page.css('table#pricing tr th')
			nodes = page.css('table#pricing tr td')
			# Go through each row in the table
			for i in 0..((nodes.count/headers.count)-1)
				# get the count, price per and the max price for at the count
				count = nodes[0 + i].content.to_f
				price_per = nodes[1 + i].content.to_f
				price_ext = nodes[2 + i].content.to_f
				# if a price exists for the database already that has the 
				price = Costing.find_by({part_no: no, count: count})
				if price
					price.price_per = price_per
					price.price_ext = price_ext
					price.save
				else
					Costing.find_or_create_by({part_no: no, count: count, 
						price_per: price_per, price_ext: price_ext, supplier: "Digi-Key"})
				end
			end
		end

		task :desc => :environment do
			# get all part numbers 
			page_no = Part.pluck(:part_number)
			# for all part numbers in the db
			part_no.each do |no|
				# get the HTML of the page 
				page =  Nokogiri::HTML(open(url + no))
				# Get the headers and body of the pricing table
				headers = page.css('table#pricing tr th')
				nodes = page.css('table#pricing tr td')
				# Go through each row in the table
				for i in 0..((nodes.count/headers.count)-1)
					# get the count, price per and the max price for at the count
					count = node[0 + i].to_f
					price_per = node[1 + i].to_f
					price_ext = node[2 + i].to_f
					# if a price exists for the database already that has the 
					price = Costing.find_by({part_no: no, count: count})
					if price
						price.price_per = price_per
						price.price_ext = price_ext
						price.save
					else
						Costing.find_or_create_by({part_no: no, count: count, 
							price_per: price_per, price_ext: price_ext})
					end
				end
			end
		end
	end
end