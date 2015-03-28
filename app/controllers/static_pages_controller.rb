class StaticPagesController < ApplicationController

	def home
		@user = current_user
		@parts = Part.joins(:inventory).onSale.order(sort_column + " " + sort_direction)
	end

	def about
	end

	def help 
	end
end
