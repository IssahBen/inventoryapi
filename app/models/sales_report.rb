class SalesReport
  include ActiveModel::Serialization

  def self.model_name
    ActiveModel::Name.new(self, nil, 'SalesReport')
  end
end
