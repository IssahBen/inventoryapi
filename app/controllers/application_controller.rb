class ApplicationController < ActionController::API
   acts_as_token_authentication_handler_for User, fallback: :none
   before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[number business_name])
    end
end
