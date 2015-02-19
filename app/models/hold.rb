class Hold < ActiveRecord::Base
	has_one :cart
	
	### Add when Wes Pushes carts
	#has_one :part_number

	validates :pick_up_date, presence: true
	validates :paid, presence: true
	validates :void, presence: true
end
