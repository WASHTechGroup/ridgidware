class PoPayment < ActiveRecord::Base
	validates :po_number, presence: true, uniquness: {:message => "Order Po already exists."}
	validates :order_no, presence: true
end
