# frozen_string_literal: true

require 'ostruct'
class Transaction < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse
  enum transaction_type: {
    inbound: 0,
    adjustment: 1,
    outbound: 2 # optional: add more as needed
  }

  def self.total_sales
    total = 0
    Transaction.all.each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total
  end

  def self.average_order_value
    total_sales / Transaction.count if Transaction.count.positive?
  end

  def self.total_quantity_sold
    total = 0
    Transaction.all.each do |transaction|
      total += transaction.quantity
    end
    total
  end

  def self.total_quantity_in_stock
    total = 0
    Product.all.each do |product|
      total += product.stock_items.sum(:quantity)
    end
    total
  end

  def self.total_value_of_stock
    total = 0
    Product.all.each do |product|
      total += product.price * product.stock_items.sum(:quantity)
    end
    total
  end

  def self.day_sale
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_day).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total
  end

  def self.week_sale
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_week).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total
  end

  def self.month_sale
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_month).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total
  end

  def self.day_average_order_value
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_day).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    result = total / Transaction.where('created_at >= ?', Time.zone.now.beginning_of_day).count if Transaction.where(
      'created_at >= ?', Time.zone.now.beginning_of_day
    ).count.positive?
    return 0 if result.nil?

    result
  end

  def self.week_average_order_value
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_week).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total / Transaction.where('created_at >= ?', Time.zone.now.beginning_of_week).count if Transaction.where(
      'created_at >= ?', Time.zone.now.beginning_of_week
    ).count.positive?
  end

  def self.month_average_order_value
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_month).each do |transaction|
      value = transaction.product.price * transaction.quantity
      total += value
    end
    total / Transaction.where('created_at >= ?', Time.zone.now.beginning_of_month).count if Transaction.where(
      'created_at >= ?', Time.zone.now.beginning_of_month
    ).count.positive?
  end

  def self.day_quantity_sold
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_day).each do |transaction|
      total += transaction.quantity
    end
    total
  end

  def self.week_quantity_sold
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_week).each do |transaction|
      total += transaction.quantity
    end
    total
  end

  def self.month_quantity_sold
    total = 0
    Transaction.where('created_at >= ?', Time.zone.now.beginning_of_month).each do |transaction|
      total += transaction.quantity
    end
    total
  end

  def self.top_3_selling_products
    Transaction
      .joins(:product)
      .group('products.id', 'products.name', 'products.price')
      .order('SUM(transactions.quantity) DESC')
      .limit(3)
      .pluck('products.name', 'SUM(transactions.quantity)', 'products.price')
      .map { |name, quantity, price| { name: name, total_quantity: quantity, price: price } }
  end
end
