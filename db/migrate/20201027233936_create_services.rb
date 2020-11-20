class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.string :kind
      t.string :phone_number
      t.string :url
      t.string :picture

      t.timestamps
    end
  end
end
