class PoPayment < ActiveRecord::Base
	validates :po_number, presence: true, uniquness: true
	validates :order_no, presence: {:message => "Order Po already exists."}
end
