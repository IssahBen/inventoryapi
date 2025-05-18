# app/serializers/transaction_report_serializer.rb
class TransactionReportSerializer < ActiveModel::Serializer
  attributes :day, :week, :month, :today_transactions, :week_transactions, :month_transactions

  def day
    [
      { title: 'Total Transactions', value: Transaction.total_transactions_today }
    ]
  end

  def week
    [
      { title: 'Total Transactions', value: Transaction.total_transactions_this_week }
    ]
  end

  def month
    [
      { title: 'Total Transactions', value: Transaction.total_transactions_this_month }
    ]
  end

  def today_transactions
    Transaction.today_transactions
  end

  def week_transactions
    Transaction.week_transactions
  end

  def month_transactions
    Transaction.month_transactions
  end
end
