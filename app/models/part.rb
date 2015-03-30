class Part < ActiveRecord::Base
	## check part number exists and is unique when adding new part to catalogue
	validates :part_number, presence: true
	## check that a description exists when ading new parts to the catalogue (not functional requirement, for administrator)
	validates :description, presence: true

	has_one :inventory, dependent: :destroy, autosave: true
	accepts_nested_attributes_for :inventory, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	has_many :inventory_history
	has_many :parts_in_order
	has_many :orders, through: :parts_in_order
	belongs_to :category
	before_save :save_inventory 

	attr_accessor :inventory_attributes

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			where(nil)
		end
	end

	def self.onSale
		# joins(:inventory).where('price > 0 AND on_hand > 0')
		where('price > 0')
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
		record_history
		inventory.on_hold = value
	end

	def on_order=(value)
		record_history
		inventory.on_order = value
	end

	def on_hand=(value)
		record_history
		inventory.on_hand = value
	end

	#def description=(value)
	#	description = value
	#end

	private 

		def create_inventory
			inventory ||= Inventory.new
		end

		def record_history
			temp =  InventoryHistory.new
			temp.part_id = id
			temp.on_hand = on_hand
			temp.on_order = on_order
			temp.on_hold = on_hold
			temp.save!
			inventory_history << temp
		end

		def save_inventory
			if inventory_attributes 
				inventory_attributes.each do |k, v|
					on_hand = v[:on_hand]
					on_order = v[:on_order]
				end
			end 
		end 
end
