class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :cart_id, null: false, unique: true
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.decimal :amount_given
      t.decimal :change
      t.timestamps null: false
    end
  end
end
