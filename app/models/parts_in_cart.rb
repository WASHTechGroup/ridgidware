class PartsInCart < ActiveRecord::Base
	belongs_to :cart

	belongs_to :part

	before_create :default_quantity

	## when you find part in this cart, you can use this line to find the quantity

	def quantity_requested=(value)
		write_attribute(:quantity_requested, value)
	end

	private
		def default_quantity 
			self.quantity_requested = 1
		end
end
