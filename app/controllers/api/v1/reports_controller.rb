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
        scheduled_at_str = params.dig(:report, :scheduled_at)

        if scheduled_at_str
          scheduled_date = Time.iso8601(scheduled_at_str).to_date

          start_of_day = scheduled_date.beginning_of_day
          end_of_day = scheduled_date.end_of_day

          @transactions = Transaction.where(created_at: start_of_day..end_of_day)
        else
          @transactions = Transaction.all
        end

        transactions = @transactions.map do |transaction|
          {
            id: transaction.id,
            product_name: transaction.product.name,
            total_value: transaction.product.price * transaction.quantity,
            date: transaction.created_at.strftime('%Y-%m-%d %H:%M:%S')
          }
        end

        render json: transactions
      end

      private
    end
  end
end
