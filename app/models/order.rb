class Order < ActiveRecord::Base
	has_many :parts_in_order, autosave: true 
	accepts_nested_attributes_for :parts_in_order, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	has_many :parts, through: :parts_in_order
	accepts_nested_attributes_for :parts, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

	attr_accessor :parts_in_order_attributes

	after_create :fill_part_list
	before_save :fill_part_list

	private
		def fill_part_list
			if self.id != nil
				parts_in_order_attributes.each do |k, v|
					puts v[:_destroy]
					if(!v[:_destroy]) 
						puts "Destroy"
						list_item = PartsInOrder.find_or_create_by({part_id: v[:part_id].to_i, order_id: self.id})
						list_item.destroy!
					else
						puts "Create"
						list_item = PartsInOrder.find_or_create_by({part_id: v[:part_id].to_i, order_id: self.id})
						list_item.amount = v[:amount]
						list_item.cost = v[:cost]
						list_item.save!
					end
				end
			end
		end
end
