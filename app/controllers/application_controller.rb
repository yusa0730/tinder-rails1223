class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Deviseのデフォルトではメールアドレスとパスワードしか編集することはできません。
  # configure_permitted_parametersメソッド内で編集できるカラムを指定します。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :self_introduction, :profile_image])
  end
end
