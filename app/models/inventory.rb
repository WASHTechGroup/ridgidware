class Inventory < ActiveRecord::Base
	belongs_to :part

	after_initialize  :set_zeros
	before_save :calc_position
	before_save :calc_available

	NUMERIC_REGEX = /\A\d+\Z/
	validates :on_hand, format: {with: NUMERIC_REGEX}
	validates :on_order, format: {with: NUMERIC_REGEX}
	validates :on_hold, format: {with:NUMERIC_REGEX}

	private
		def calc_position
		    self.inv_position = self.on_hand + self.on_order - self.on_hold		
		end    	
		def calc_available
			self.available = self.on_hand - self.on_hold
		end

		def set_zeros
			self.on_hold = 0
			self.on_order = 0
			self.on_hand = 0
			self.available = 0
			self.inv_position = 0
		end
end
