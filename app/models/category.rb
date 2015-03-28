class Category < ActiveRecord::Base
	has_many :parts
	validates :name, presence: true

end
