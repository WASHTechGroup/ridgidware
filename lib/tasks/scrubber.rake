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
					Costing.find_or_create_by({part_no: no, count: count, price_per: price_per, price_ext: price_ext, supplier: "Digi-Key"})
				end
			end
		end
	end

	task :desc => :environment do
		# get all part numbers 
		page_no = Part.pluck(:part_number)
		# for all part numbers in the db
		page_no.each do |no|
			# get the HTML of the page 
			page =  Nokogiri::HTML(open("#{url}#{no}"))
			# Get the headers and body of the pricing table
			desc = page.css('.product-details-table td[itemprop="description"]').text
			# Set the desc based on part numnbers
			part = Part.find_by({part_number: no})
			# Set the descriptions and save
			part.description = desc
			part.save!
		end
	end

	task :cate => :environment do
		# get all part numbers 
		page_no = Part.pluck(:part_number)
		# for all part numbers in the db
		page_no.each do |no|
			# get the HTML of the page 
			page =  Nokogiri::HTML(open("#{url}#{no}"))
			# Get the headers and body of the pricing table
			td_nodes = page.css('.product-additional-info td.attributes-table-main tr td')	
			th_nodes = page.css('.product-additional-info td.attributes-table-main tr th')	
			for n in 0..(td_nodes.length - 1)
				if (th_nodes[n].text == "Category")
					cat_name = td_nodes[n].text
					cat_name.strip!
				end
			end
			catagory = Category.find_or_create_by({name: cat_name})
			# Set the desc based on part numnbers				
			part = Part.find_by({part_number: no})
			# Set the descriptions and save
			part.category = catagory
			part.save!
		end
	end

	task :all => [:costs, :desc, :cate]
end