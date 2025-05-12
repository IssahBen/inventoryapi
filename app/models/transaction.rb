# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse
  enum transaction_type: {
    inbound: 0,
    adjustment: 1,
    outbound: 2 # optional: add more as needed
  }
end
