# frozen_string_literal: true

class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse
end
