class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true, uniqueness: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true

	has_one :inventory, dependent: :destroy, autosave: true


	# before_create :create_inventory

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			where(nil)
		end
	end

	def on_hold
		inventory.on_hold
	end

	def on_order
		inventory.on_order
	end

	def on_hand
		inventory.on_hand
	end

	def available
		inventory.available
	end

	def inv_position
		inventory.inv_position
	end

	private 

		def create_inventory
			inventory ||= Inventory.new
		end
end
