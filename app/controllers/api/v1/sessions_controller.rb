# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: user_params[:email])
        if user&.valid_password?(user_params[:password])
          if user.authentication_token.blank?
            user.authentication_token = Devise.friendly_token
            user.save
          end

          render json: { token: user.authentication_token, user: user.as_json }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        current_user.authentication_token = Devise.friendly_token
        current_user.save
        render json: { message: 'Success' }
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
