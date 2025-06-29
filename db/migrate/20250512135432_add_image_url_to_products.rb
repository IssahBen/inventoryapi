# frozen_string_literal: true

class AddImageUrlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :image_url, :string
  end
end
