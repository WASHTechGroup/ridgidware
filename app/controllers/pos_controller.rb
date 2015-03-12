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
		@parts = Part.order(sort_column + " " + sort_direction)
	end
	
	def returns 
 	end

 	def print_recipt
 	end

 	private
 		def sort_column 
 			%w[part_number description price].include?(params[:sort]) ? params[:sort] : "part_number"
 		end

 		def sort_direction
 			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
 		end
end
