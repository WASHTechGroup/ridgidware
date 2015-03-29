class AdminController < ApplicationController
	before_filter :tier_three, only: :index

	def index
		@parts = Part.joins(:inventory).order(sort_column + " " + sort_direction)
	end

	private

 		def sort_column 
 			%w[part_number description price on_hand on_order available].include?(params[:sort]) ? params[:sort] : "part_number"
 		end

 		def sort_direction
 			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
 		end
end
