class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :cart_id, null: false, unique: true
      t.float :subtotal
      t.float :tax
      t.float :total
      t.float :amount_given
      t.float :change
      t.timestamps null: false
    end
  end
end
