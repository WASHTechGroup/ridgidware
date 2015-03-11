class Costing < ActiveRecord::Base
	validates :part_no, presence: true
	validates :price_per, presence: true
	validates :price_ext, presence: true
end