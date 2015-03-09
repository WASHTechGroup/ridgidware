class Transaction < ActiveRecord::Base
	has_one :cart

	before_save :calculate_chage

	validates :cart_id, presence: true
	validates :subtotal, presence: true
	validates :tax, presence: true
	validates :total, presence: true
	validates :amount_given, presence: true
	validates :change, presence: true

	private
		def calculate_change
			self.change = self.amount_given - self.total
		end
end
