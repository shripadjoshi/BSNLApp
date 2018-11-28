class SimTargetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_role
  @@months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    

  def index
    @sim_targets = SimTarget.paginate(:page => params[:page], :per_page => 10)
    add_breadcrumb "SIM Targets", :sim_targets_path
  end

  def new
    @sim_target = SimTarget.new
    @months = @@months
    add_breadcrumb "new SIM Target", :new_sim_target_path
  end

  def edit
    @sim_target = get_sim_target
    @months = @@months
    add_breadcrumb "edit SIM Target", :edit_sim_target_path
  end

  def create

    target_params = {
      year: params[:sim_target][:year],
      target: params[:sim_target].values.slice(1,12).join(",")
    }
    @sim_target = SimTarget.new(target_params)
    if @sim_target.save
      redirect_to sim_targets_path
    else
      @months = @@months
      render 'new'
    end
  end

  def update
    @sim_target = get_sim_target

    target_params = {
      year: params[:sim_target][:year],
      target: params[:sim_target].values.slice(1,12).join(",")
    }

    if @sim_target.update_attributes(target_params)
      redirect_to sim_targets_path
    else
      render 'edit'
    end
  end

  def destroy
    @sim_target = get_sim_target
    @sim_target.destroy

    redirect_to sim_targets_path
  end

  private

  def get_sim_target
    SimTarget.find(params[:id])
  end

  
end
