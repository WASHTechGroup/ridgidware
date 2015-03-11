class PartsInOrder < ActiveRecord::Base
	has_one :order
	has_many :parts
end
