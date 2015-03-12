class CreatePoPayments < ActiveRecord::Migration
  def change
    create_table :po_payments do |t|
    	t.string :po_number
    	t.integer :order_no
    	t.integer :cheque_no
      t.timestamps null: false
    end
  end
end
