class AddValuesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :email, :string
  	add_column :users, :phonenumber, :string
  	add_column :users, :program, :integer
  	add_column :users, :term, :string
  	add_column :users, :year, :integer
  end
end
