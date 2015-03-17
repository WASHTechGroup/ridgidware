class CreatePartsInOrders < ActiveRecord::Migration
  def change
    create_table :parts_in_orders do |t|
    	t.integer :order_id
    	t.integer :part_id
    	t.integer :quant_ordered
    	t.integer :quant_received
    	t.integer :quant_backordered
    	t.float   :cost
      t.timestamps null: false
    end
  end
end
