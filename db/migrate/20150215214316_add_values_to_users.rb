class AddValuesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :email, :string
  	add_column :users, :phonenumber, :string
  	add_column :users, :major, :integer
  	add_column :users, :year, :string
  end
end
