class CreateCostings < ActiveRecord::Migration
  def change
    create_table :costings do |t|
    	t.string :part_no
    	t.integer :count
    	t.float :price_per
    	t.float :price_ext
    	t.string :supplier
     	t.timestamps null: false
    end
  end
end