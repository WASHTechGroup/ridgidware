class PosController < ApplicationController
	helper_method :sort_column, :sort_direction

	def index
		if !current_user.cart 
			current_user.cart = Cart.new
			current_user.cart.owner = current_user.username
			current_user.cart.save!
		end
		@cart = current_user.cart
		@parts_in_cart = @cart.parts_in_cart
		@parts = Part.onSale.order(sort_column + " " + sort_direction)
	end

	def returns
		trans_id = params[:transaction_id]
		@transaction = trans_id != nil ? Transaction.find(trans_id) : nil
		@cart_to_return = @transaction != nil ? Cart.find(@transaction.cart_id) : nil
		@parts_in_cart = @cart_to_return != nil ? @cart_to_return.parts_in_cart : nil
		
		# Getting the returning cart from the session 
		@cart_retruning = nil
		if session[:returns_cart]
			@cart_retruning = Cart.find(session[:returns_cart])
			puts "Parts In Cart : #{@cart_retruning.id}"
		else
			@cart_retruning = Cart.find_by({owner: "#{current_user.username}_returns"})
			if !@cart_retruning 
				@cart_retruning = Cart.new
				@cart_retruning.owner = "#{current_user.username}_returns"
				@cart_retruning.save!
				session[:returns_cart] = @cart_retruning.id	
			end
		end
		@parts_returning_cart = @cart_retruning.parts_in_cart
		# Delete all entries in this cart on refresh
		@parts_returning_cart.each do |part|
		part.destroy!
	end

		if @parts_in_cart && @parts_returning_cart.length != @parts_in_cart.length
=begin
			@parts_returning_cart.each do |part|
				part.destroy!
			end
=end			
			# Fill the cart with stuff
			@parts_in_cart.each do |part|
				pic = PartsInCart.new({part_id:part.part_id, cart_id:@cart_retruning.id})
				pic.quantity_requested = 0
				@parts_returning_cart << pic
			end
			@cart_retruning.save!
		end
 	end

 	def recipt
 		@transaction = Transaction.find(params[:transaction_id])
 		@cart = Cart.find(@transaction.cart_id)
 		@parts_in_cart = @cart.parts_in_cart
 		respond_to do |format| 
    		format.pdf do
        	 	render pdf: "RigidWare - Weekly - #{Time.zone.now.to_date}",
               		   template: 'reports/daily.pdf.html',
               		   disposition: 'attachment',
               		   toc: { depth: 2, 
               				  header_text: 'TEXT', 
               				  disable_links: false }
      		end
		end
 	end

 	private
 		def sort_column 
 			%w[part_number description price].include?(params[:sort]) ? params[:sort] : "part_number"
 		end

 		def sort_direction
 			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
 		end
end
