class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true

	has_one :inventory, dependent: :destroy, autosave: true
	accepts_nested_attributes_for :inventory, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	has_many :parts_in_order
	has_many :orders, through: :parts_in_order

	# before_create :create_inventory

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			where(nil)
		end
	end

	# Getter Values 
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

	# Setter Values
	def on_hold=(value)
		inventory.on_hold = value
	end

	def on_order=(value)
		inventory.on_order = value
	end

	def on_hand=(value)
		inventory.on_hand = value
	end

	private 

		def create_inventory
			inventory ||= Inventory.new
		end
end
