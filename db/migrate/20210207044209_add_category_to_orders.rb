class AddCategoryToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :category, null: false, foreign_key: true
  end
end
