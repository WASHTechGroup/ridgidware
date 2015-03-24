class Transaction < ActiveRecord::Base
	belongs_to :cart
	belongs_to :user

	before_save :calculate_change

	validates :cart_id, presence: true
	validates :subtotal, presence: true
	validates :tax, presence: true
	validates :total, presence: true
	validates :amount_given, presence: true
	validates :change, presence: true

	def checkout
		# cart = Cart.find(cart_id)
		cpic = cart.parts_in_cart
		cpic.each do |in_cart|
			part = Part.find(in_cart.part_id)
			part.on_hand = part.on_hand - in_cart.quantity_requested
			part.save!
		end
	end

	def return
		cart = Cart.find(cart_id)
		cpic = cart.parts_in_cart
		cpic.each do |in_cart|
			part = Part.find(in_cart.part_id)
			part.on_hand = part.on_hand - in_cart.quantity_requested
			part.save!
		end
	end

	def cashier_username
		user ? user.username : nil
	end

	def cashier_name
		user ? user.full_name : nil
	end

	private
		def calculate_change
			self.change ||= self.amount_given - self.total
		end
end
