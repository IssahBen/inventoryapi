module Api
  module V1
    class ReportsController < ApplicationController
      def sales_report
        render json: serialize_sales_report, status: :ok
      end

      def stock_report
        render json: serialize_stock_report, status: :ok
      end

      def transaction_report
        render json: serialize_transaction_report, status: :ok
      end

      private

      def serialize_sales_report
        { All: [{ title: 'Total Sale', value: Transaction.total_sales }, { title: 'Average Order value', value: Transaction.average_order_value }, { title: 'Total Orders', value: Transaction.total_quantity_sold }],
          Day: [{ title: 'Total Sale', value: Transaction.day_sale },
                { title: 'Average Order value', value: Transaction.day_average_order_value }, { title: 'Total Orders', value: Transaction.day_quantity_sold }],
          Week: [{ title: 'Total Sale', value: Transaction.week_sale },
                 { title: 'Average Order value', value: Transaction.week_average_order_value }, { title: 'Total Orders', value: Transaction.week_quantity_sold }],
          Month: [{ title: 'Total Sale', value: Transaction.month_sale },
                  { title: 'Average Order value', value: Transaction.month_average_order_value }, { title: 'Total Orders', value: Transaction.month_quantity_sold }],
          Top: Transaction.top_3_selling_products }
      end

      def serialize_stock_report
        { metrics: [{ title: 'Total Items', value: StockItem.total_items }, { title: 'Low Stock Items', value: StockItem.low_stock_items }, { title: 'Out of Stock Items', value: StockItem.out_of_stock_items }],
          current_stock: StockItem.current_stock }
      end

      def serialize_transaction_report
        { day: [{ title: 'Total Transactions', value: Transaction.total_transactions_today }],
          week: [{ title: 'Total Transactions', value: Transaction.total_transactions_this_week }],
          month: [{ title: 'Total Transactions', value: Transaction.total_transactions_this_month }],
          today_transactions: Transaction.today_transactions,
          week_transactions: Transaction.week_transactions,
          month_transactions: Transaction.month_transactions }
      end
    end
  end
end
