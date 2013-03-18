class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_users_only

  def index
    respond_to do  |format|
      format.html
      format.json { render json: @users.to_json }
    end
  end

  def update
    user = User.find(params['id'])
    user.update_attributes params['user']
    user.role_names = params['role_names'] if params['role_names']
    respond_to do  |format|
      format.json { render json: user.to_json}
    end
  end

  def admin_users_only
    redirect_to :root, flash: {notice: 'You must be an admin user!'} unless current_user.has_role? 'admin'
  end

end
