class Order < ActiveRecord::Base
	has_many :parts_in_order, autosave: true 
	accepts_nested_attributes_for :parts_in_order, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	has_many :parts, through: :parts_in_order
	accepts_nested_attributes_for :parts, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

	attr_accessor :parts_in_order_attributes

	after_create :fill_part_list
	before_save :fill_part_list
	before_save :calculate

	private
		def fill_part_list
			if self.id != nil
				parts_in_order_attributes.each do |k, v|
					puts "Create"
					list_item = PartsInOrder.find_or_create_by({part_id: v[:part_id].to_i, order_id: self.id})
					old_order = list_item.quant_ordered.nil? ? 0 : list_item.quant_ordered
					list_item.quant_ordered = v[:quant_ordered]
					list_item.cost = v[:cost]
					list_item.save!
					part = Part.find(v[:part_id].to_i)
					part.on_order = (part.on_order - old_order) + v[:quant_ordered].to_i
					part.save!
				end
			end
		end

		def calculate
			self.subtotal = 0
			parts_in_order.each do |part|
				self.subtotal = subtotal + (part.quant_ordered * part.cost)
			end
			self.tax = subtotal * 0.13
			self.total = subtotal + tax
		end
end
