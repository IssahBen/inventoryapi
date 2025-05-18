# app/serializers/stock_report_serializer.rb
class StockReportSerializer < ActiveModel::Serializer
  attributes :metrics, :current_stock

  def metrics
    [
      { title: 'Total Items', value: StockItem.total_items },
      { title: 'Low Stock Items', value: StockItem.low_stock_items },
      { title: 'Out of Stock Items', value: StockItem.out_of_stock_items },
      { title: 'Total Inventory Value $', value: StockItem.total_inventory_value },
      { title: 'Number of Products', value: Product.count }
    ]
  end

  def current_stock
    StockItem.current_stock
  end
end
