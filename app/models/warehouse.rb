class Warehouse < ApplicationRecord
  has_many :stock_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
