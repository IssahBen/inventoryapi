class Product < ApplicationRecord
  has_many :stock_items, dependent: :destroy
  belongs_to :category
  has_one_attached :image
end
