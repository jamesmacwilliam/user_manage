class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path alert: exception.message
  end

  def only_allow_admin
    redirect_to root_path alert: 'Not authorized as an administrator.' unless current_user.has_role? :admin
  end
end
