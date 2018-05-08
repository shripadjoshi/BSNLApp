class RolesController < ApplicationController
  before_action :authenticate_user!
  #before_filter :authorize_role, only: [:new, :create]

  def index
    @roles = Role.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @role = Role.new
  end

  def edit
    @role = get_role
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def update
    @role = get_role

    if @role.update_attributes(role_params)
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    @role = get_role
    @role.destroy 
    
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def get_role
    Role.find(params[:id])
  end


end
