class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true, uniqueness: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true
	## check part is assigned to a supplier to allow for ordering of this part
	validates :default_supplier, presence: true

	has_one :inventory
end
