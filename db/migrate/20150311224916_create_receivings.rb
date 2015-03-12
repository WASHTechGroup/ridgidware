class CreateReceivings < ActiveRecord::Migration
  def change
    create_table :receivings do |t|
    	t.integer :part_id
    	t.integer :quant_received
    	t.integer :quant_backordered
    	t.text :comment
      t.timestamps null: false
    end
  end
end
