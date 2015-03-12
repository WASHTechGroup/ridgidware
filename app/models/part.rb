class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true, uniqueness: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true

	has_one :inventory, dependent: :destroy, autosave: true


	before_create :create_inventory

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			where(nil)
		end
	end

	def self.on_hold
		self.inventory.on_hold
	end

	def self.on_order
		self.inventory.on_order
	end

	def self.on_hand
		self.inventory.on_hand
	end

	def self.available
		self.inventory.available
	end

	def self.inv_position
		self.inventory.inv_position
	end

	private 

		def create_inventory
			self.inventory = Inventory.new
		end
end
