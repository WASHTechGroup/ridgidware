class Cart < ActiveRecord::Base
	belongs_to :transactions
	belongs_to :holds
	has_many :parts_in_cart

	## Lets us add items to the cart, Parts is now an element in cart

	has_many :parts, through: :parts_in_cart
end
