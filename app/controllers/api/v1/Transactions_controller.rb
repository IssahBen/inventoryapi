# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        service = Transactions::CreateCartService.new(transaction_params)
        success = service.call

        if success
          render json: { message: 'All transactions completed successfully', details: service.success },
                 status: :created
        else
          render json: { errors: service.errors, success: service.success }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params[:transaction]
      end
    end
  end
end
