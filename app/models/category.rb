class Category < ActiveRecord::Base
	has_many :parts
	validates :category_name, presence: true, uniqueness: {:message => "Category already exists."}

end
