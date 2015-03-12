class Category < ActiveRecord::Base
	has_many :parts

	validates :category_id, presence: true, uniqueness: true
	validates :category_name, presence: true, uniqueness: true

end
