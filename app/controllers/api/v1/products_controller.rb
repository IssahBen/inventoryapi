# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include Rails.application.routes.url_helpers

      def create
        category = Category.find_or_create_by(name: product_params[:category].capitalize)

        product = Product.new(product_params.except(:category, :quantity))
        product.category_id = category.id

        if product.save
          stock_item = StockItem.new(
            product_id: product.id,
            quantity: product_params[:quantity],
            warehouse_id: Warehouse.first.id # Assuming you want to assign the first warehouse
          )

          if stock_item.save
            render json: {
              message: 'Product created successfully'
            }, status: :created
          else
            product.destroy # Roll back product if stock item fails
            render json: { errors: stock_item.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def products_list
        products = Product.all
        render json: serialize_products(products), status: :ok
      end

      def edit_product
        product = Product.find_by(id: params[:id])
        p params[:id]
        render json: serialize_product_edit(product), status: :ok
      end

      private

      def product_params
        params.permit(:name, :cost, :price, :image_url, :reorder_level, :description, :category, :quantity)
      end

      def serialize_product(product)
        {
          id: product.id,
          name: product.name.upcase,
          price: product.price,
          category: category_name(product.category_id),
          quantity: product.stock_items.sum(:quantity)
        }
      end

      def serialize_products(products)
        products.map { |product| serialize_product(product) }
      end

      def serialize_product_edit(product)
        {
          id: product.id,
          name: product.name,
          price: product.price,
          cost: product.cost,
          description: product.description,
          quantity: product.stock_items.sum(:quantity),
          category: category_name(product.category_id)
        }
      end

      def category_name(id)
        category = Category.find_by(id: id)
        category ? category.name : 'Unknown'
      end
    end
  end
end
