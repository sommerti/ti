class AddPersonalDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :role, :string
  end
end
