class PartsInOrder < ActiveRecord::Base
	belongs_to :order
	belongs_to :part

	before_save :default_order

	private
		def default_order
			self.quant_ordered ||= 0
			self.quant_received ||= 0
			self.quant_backordered ||= 0
		end
end
