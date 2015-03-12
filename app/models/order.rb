class Order < ActiveRecord::Base
	has_many :parts_in_order
	has_many :parts, through: :parts_in_order
end
