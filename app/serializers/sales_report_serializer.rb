class SalesReportSerializer < ActiveModel::Serializer
  attributes :all, :day, :week, :month, :top

  def all
    [
      { title: 'Total Sale', value: Transaction.total_sales },
      { title: 'Average Order value', value: Transaction.average_order_value },
      { title: 'Total Orders', value: Transaction.total_quantity_sold }
    ]
  end

  def day
    [
      { title: 'Total Sale', value: Transaction.day_sale },
      { title: 'Average Order value', value: Transaction.day_average_order_value },
      { title: 'Total Orders', value: Transaction.day_quantity_sold }
    ]
  end

  def week
    [
      { title: 'Total Sale', value: Transaction.week_sale },
      { title: 'Average Order value', value: Transaction.week_average_order_value },
      { title: 'Total Orders', value: Transaction.week_quantity_sold }
    ]
  end

  def month
    [
      { title: 'Total Sale', value: Transaction.month_sale },
      { title: 'Average Order value', value: Transaction.month_average_order_value },
      { title: 'Total Orders', value: Transaction.month_quantity_sold }
    ]
  end

  def top
    Transaction.top_3_selling_products
  end
end
