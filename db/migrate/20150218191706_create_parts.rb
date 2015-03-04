class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
    	t.integer :part_no, 		:null => false
    	t.string :description
    	t.float :price
    	t.float :cost
    	t.string :defaultsupplier
      t.timestamps null: false
    end
  end
end
