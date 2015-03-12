class CreateDemandTrackers < ActiveRecord::Migration
  def change
    create_table :demand_trackers do |t|

      t.timestamps null: false
    end
  end
end
