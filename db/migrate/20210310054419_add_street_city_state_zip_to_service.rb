class AddStreetCityStateZipToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :street, :string
    add_column :services, :city, :string
    add_column :services, :state, :string
    add_column :services, :zip, :string
  end
end
