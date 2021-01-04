class AddStreetToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :street, :string
  end
end
