class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.integer :order_no
    	t.float		:cost
    	t.float		:subtotal
    	t.float		:tax
    	t.float		:total
    	t.text	:comment
      t.timestamps null: false
    end
  end
end
