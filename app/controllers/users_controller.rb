class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
    add_breadcrumb "users", :users_path
  end

  def status
    user = User.find(params[:id])
    user.update_attributes!(account_active: !user.account_active)
    head :ok
  end
end
