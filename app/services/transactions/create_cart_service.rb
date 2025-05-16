# app/services/transactions/create_cart_service.rb
module Transactions
  class CreateCartService
    def initialize(cart_params)
      @cart = cart_params
      @errors = []
      @success = []
    end

    attr_reader :errors, :success

    def call
      @cart.each do |item|
        product = Product.find(item[:id])
        purchased_quantity = item[:quantity].to_i
        stock_item = product.stock_items.first

        if stock_item.nil?
          @errors << "No stock found for #{product.name}"
          next
        end

        if stock_item.quantity < purchased_quantity
          @errors << "Insufficient stock for #{product.name}"
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
            @success << "#{product.name} purchased successfully"
          else
            @errors << "Failed to save transaction for #{product.name}: #{transaction.errors.full_messages.join(', ')}"
            raise ActiveRecord::Rollback
          end
        end
      end

      errors.empty?
    end
  end
end
