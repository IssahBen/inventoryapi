class CreateWarehouses < ActiveRecord::Migration[7.1]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
