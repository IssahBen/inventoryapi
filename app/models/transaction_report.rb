# app/models/transaction_report.rb
class TransactionReport
  include ActiveModel::Serialization

  def self.model_name
    ActiveModel::Name.new(self, nil, 'TransactionReport')
  end
end
