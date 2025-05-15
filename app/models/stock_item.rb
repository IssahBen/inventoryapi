# frozen_string_literal: true

class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  def self.total_items
    total = 0
    StockItem.all.each do |stock_item|
      total += stock_item.quantity
    end
    total
  end

  def self.low_stock_items
    low_stock_items = 0
    StockItem.all.each do |stock_item|
      low_stock_items += 1 if stock_item.quantity < stock_item.product.reorder_level
    end
    low_stock_items
  end

  def self.out_of_stock_items
    out_of_stock_items = 0
    StockItem.all.each do |stock_item|
      out_of_stock_items += 1 if stock_item.quantity.zero?
    end
    out_of_stock_items
  end

  def self.current_stock
    current_stock = []
    StockItem.all.each do |stock_item|
      current_stock << {
        product_name: stock_item.product.name,
        quantity: stock_item.quantity
      }
    end
    current_stock
  end
end
