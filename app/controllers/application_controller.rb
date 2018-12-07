class ApplicationController < ActionController::Base
  # deviseでuser_nameカラム追加時の設定
  before_action :configure_permitted_params, if: :devise_controller?

  private
    # deviseでuser_nameカラム追加時の設定
    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end

    # deviseでのログイン後の遷移先の設定
    def after_sign_in_path_for(resource)
      user_path(current_user)
    end
end
