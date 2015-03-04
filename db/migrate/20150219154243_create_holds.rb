class CreateHolds < ActiveRecord::Migration
  def change
    create_table :holds do |t|
      t.integer :cart_id
      t.timestamps :Pick_up_date
      t.boolean :paid
      t.boolean :void
      t.timestamps null: false
    end
  end
end
