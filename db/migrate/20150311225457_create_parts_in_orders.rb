class CreatePartsInOrders < ActiveRecord::Migration
  def change
    create_table :parts_in_orders do |t|
    	t.integer :order_no
    	t.integer :part_id
      t.timestamps null: false
    end
  end
end
