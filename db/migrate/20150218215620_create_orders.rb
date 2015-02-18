class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.integer :order_no
    	t.integer :part_no
    	t.integer :order_quantity
    	t.float		:unit_cost
    	t.float		:cost
    	t.float		:subtotal
    	t.float		:tax
    	t.float		:total
    	t.integer	:quantity_received
    	t.integer	:quantity_backordered
    	t.string	:comment
      t.timestamps null: false
    end
  end
end
