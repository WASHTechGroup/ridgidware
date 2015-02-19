class CreatePartsInCarts < ActiveRecord::Migration
  def change
    create_table :parts_in_carts do |t|
      t.integer :cart_id, null: false
      t.integer :part_id, null: false
      t.integer :quantity_requested, null:false
      t.timestamps null: false
    end
  end
end
