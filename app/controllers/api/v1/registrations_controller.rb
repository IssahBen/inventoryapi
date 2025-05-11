class Api::V1::RegistrationsController < Devise::RegistrationsController
      
      def create
        user = User.new(user_params)

        if user.save
          # UserMailer.welcome_email(user).deliver_now
          render json: { token: user.authentication_token, user: user.as_json }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private 

      def user_params 
        params.require(:user).permit(:email,:business_name,:number,:password,:password_confirmation)
      end
end