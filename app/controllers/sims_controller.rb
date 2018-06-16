class SimsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_role

  def index
    @sims = Sim.paginate(:page => params[:page], :per_page => 10)
    add_breadcrumb "SIMs", :sims_path
  end

  def new
    @sim = Sim.new
    add_breadcrumb "new SIM", :new_sim_path
  end

  def edit
    @sim = get_sim
    add_breadcrumb "edit SIM", :edit_sim_path
  end

  def create
    @sim = Sim.new(sim_params)

    if @sim.save
      redirect_to sims_path
    else
      render 'new'
    end
  end

  def update
    @sim = get_sim

    if @sim.update_attributes(sim_params)
      redirect_to sims_path
    else
      render 'edit'
    end
  end

  def destroy
    @sim = get_sim
    @sim.destroy

    redirect_to sims_path
  end

  private

  def sim_params
    params.require(:sim).permit(:sim_no, :sim_type, :sim_pairedness, :sim_category, :sell_status)
  end

  def get_sim
    Sim.find(params[:id])
  end
end
