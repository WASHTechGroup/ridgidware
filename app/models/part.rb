class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true, uniqueness: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true
	## check part is assigned to a supplier to allow for ordering of this part
	validates :default_supplier, presence: true

	has_one :inventory, dependent: :destroy, autosave: true

	before_create :create_inventory

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			where(nil)
		end
	end

	private 

		def create_inventory
			self.inventory = Inventory.new
		end
end
