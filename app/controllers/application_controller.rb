class ApplicationController < ActionController::Base
  PER_PAGE = 10

  protect_from_forgery
  before_filter :setup_instance_variables

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path alert: exception.message
  end

  def only_allow_admin
    redirect_to root_path alert: 'Not authorized as an administrator.' unless current_user.has_role? :admin
  end

  def setup_instance_variables
    @users = User.paginate(page: params[:page] || 1, per_page: PER_PAGE)
    @users = @users.order(first_name: 'desc')
    if params[:sort_by] && params[:direction] && User.column_names.include?(params[:sort_by])
      direction = params[:direction] == 'desc' ? 'desc' : 'asc'
      @users = @users.order("#{params[:sort_by]} #{direction}")
    end
  end
end
