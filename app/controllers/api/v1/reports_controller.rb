module Api
  module V1
    class ReportsController < ApplicationController
      def index
        render json: serialize_reports, status: :ok
      end

      private

      def serialize_reports
        { All: [{ title: 'Total Sale', value: Transaction.total_sales }, { title: 'Average Order value', value: Transaction.average_order_value }, { title: 'Total Orders', value: Transaction.total_quantity_sold }],
          Day: [{ title: 'Total Sale', value: Transaction.day_sale },
                { title: 'Average Order value', value: Transaction.day_average_order_value }, { title: 'Total Orders', value: Transaction.day_quantity_sold }],
          Week: [{ title: 'Total Sale', value: Transaction.week_sale },
                 { title: 'Average Order value', value: Transaction.week_average_order_value }, { title: 'Total Orders', value: Transaction.week_quantity_sold }],
          Month: [{ title: 'Total Sale', value: Transaction.month_sale },
                  { title: 'Average Order value', value: Transaction.month_average_order_value }, { title: 'Total Orders', value: Transaction.month_quantity_sold }],
          Top: Transaction.top_3_selling_products }
      end
    end
  end
end
