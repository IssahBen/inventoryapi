require 'ostruct'

module Api
  module V1
    class ReportsController < ApplicationController
      def sales_report
        render json: SalesReport.new, serializer: ::SalesReportSerializer, status: :ok
      end

      def stock_report
        render json: StockReport.new, serializer: ::StockReportSerializer, status: :ok
      end

      def transaction_report
        render json: TransactionReport.new, serializer: TransactionReportSerializer, status: :ok
      end

      def transactions
        p params
        before_time_str = params.dig(:report, :scheduled_at)

        if before_time_str
          before_time = Time.iso8601(before_time_str)
          @transactions = Transaction.where('created_at < ?', before_time)
        else
          @transactions = Transaction.all
        end

        transactions = @transactions.map do |transaction|
          {
            id: transaction.id,
            product_name: transaction.product.name, # use snake_case here for consistency
            total_value: transaction.product.price * transaction.quantity,
            date: transaction.created_at
          }
        end

        render json: transactions
      end

      private
    end
  end
end
