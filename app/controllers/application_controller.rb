class ApplicationController < ActionController::Base
  # deviseでログインする前のページを保存
  before_action :store_current_location, unless: :devise_controller?
  # deviseでuser_nameカラム追加時の設定
  before_action :configure_permitted_params, if: :devise_controller?

  private
    # deviseでuser_nameカラム追加時の設定
    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end

    # deviseでログインする前のページを保存
    def store_current_location
      store_location_for(:user, request.url)
    end

    # deviseでログイン後の遷移先指定
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || root_url
    end
end
