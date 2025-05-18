class AddPaymentTypeToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :payment_type, :string, default: 'Cash'
  end
end
