class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
    	t.string :part_number, 		:null => false
    	t.text :description
      t.string :manufacturer
      t.string :mfg_part_no
      t.string :category
    	t.float :price
    	t.string :default_supplier
      t.timestamps null: false
    end
  end
end
