class StockReport
  include ActiveModel::Serialization

  def self.model_name
    ActiveModel::Name.new(self, nil, 'StockReport')
  end
end
