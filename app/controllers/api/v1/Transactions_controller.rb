# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        cart = transaction_params
        errors = []
        success = []

        cart.each do |item|
          product = Product.find(item[:id])
          purchased_quantity = item[:quantity]
          stock_item = product.stock_items.first

          if stock_item.nil?
            errors << "No stock found for #{product.name}"
            next
          end

          if stock_item.quantity < purchased_quantity
            errors << "Insufficient stock for #{product.name}"
            next
          end

          ActiveRecord::Base.transaction do
            stock_item.update!(quantity: stock_item.quantity - purchased_quantity)

            transaction = Transaction.new(
              product_id: product.id,
              warehouse_id: 1,
              quantity: purchased_quantity,
              transaction_type: 0
            )

            if transaction.save
              success << "#{product.name} purchased successfully"
            else
              errors << "Failed to save transaction for #{product.name}: #{transaction.errors.full_messages.join(', ')}"
              raise ActiveRecord::Rollback
            end
          end
        end

        if errors.any?
          render json: { errors: errors, success: success }, status: :unprocessable_entity
        else
          render json: { message: 'All transactions completed successfully', details: success }, status: :created
        end
      end

      private

      def transaction_params
        params.require(:transaction)
      end
    end
  end
end
