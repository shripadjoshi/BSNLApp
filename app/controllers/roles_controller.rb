class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_role

  def index
    @roles = Role.paginate(:page => params[:page], :per_page => 10)
    add_breadcrumb "roles", :roles_path
  end

  def new
    @role = Role.new
    add_breadcrumb "new role", :new_role_path
  end

  def edit
    @role = get_role
    add_breadcrumb "edit role", :edit_role_path
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
