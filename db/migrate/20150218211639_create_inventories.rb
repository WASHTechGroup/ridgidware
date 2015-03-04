class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
    	t.integer :part_id,			:null => false
    	t.integer :on_hand
    	t.integer :on_order
    	t.integer :on_hold
    	t.integer :available
    	t.integer :inv_position
      t.timestamps null: false
    end
  end
end
