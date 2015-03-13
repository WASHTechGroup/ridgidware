class Category < ActiveRecord::Base
	has_many :parts
	validates :category_name, presence: true

end
