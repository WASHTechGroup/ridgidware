class Order < ActiveRecord::Base
	has_many :parts_in_order
	has_many :parts, through: :parts_in_order
	accepts_nested_attributes_for :parts, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
