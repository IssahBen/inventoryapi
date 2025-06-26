# app/controllers/api/v1/passwords_controller.rb
module Api
  module V1
    class PasswordsController < Devise::PasswordsController
      respond_to :json

      # POST /api/v1/password/forgot
      def create
        user = User.find_by(email: params[:email])
        if user.present?
          user.send_reset_password_instructions
          render json: { message: 'Reset password instructions sent to your email.' }, status: :ok
        else
          render json: { error: 'Email not found' }, status: :not_found
        end
      end

      # PUT /api/v1/password/reset
      def update
        p reset_password_params
        user = User.reset_password_by_token(reset_password_params)
        if user.errors.empty?
          render json: { message: 'Password has been reset successfully.' }, status: :ok
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def reset_password_params
        params.permit(:reset_password_token, :password, :password_confirmation)
      end
    end
  end
end
