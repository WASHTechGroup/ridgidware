class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
    	t.string :part_number, 		:null => false
    	t.text :description
      t.string :category
    	t.float :price
      t.timestamps null: false
    end
  end
end
