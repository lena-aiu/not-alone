class AddStateToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :state, :string
  end
end
