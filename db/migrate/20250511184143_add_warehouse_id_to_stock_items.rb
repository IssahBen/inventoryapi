class AddWarehouseIdToStockItems < ActiveRecord::Migration[7.1]
  def change
    add_column :stock_items, :warehouse_id, :integer
  end
end
