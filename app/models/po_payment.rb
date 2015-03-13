class PoPayment < ActiveRecord::Base
	validates :po_number, presence: true
	validates :order_no, presence: true
end
