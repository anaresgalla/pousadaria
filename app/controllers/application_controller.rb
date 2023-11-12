class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def redirect_owner_to_lodge_registration
    if current_owner && current_owner.lodge.blank?
      redirect_to new_lodge_path
    end
  end
end
