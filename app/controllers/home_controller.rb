class HomeController < ApplicationController
  def index
    total_sell_today = Sim.where(sell_date: Date.today)
    @prepaid_daily_sale_cnt = total_sell_today.where(sim_type: 'Prepaid').count
    @postpaid_daily_sale_cnt = total_sell_today.where(sim_type: 'Postpaid').count

    total_sell_weekly = Sim.where(sell_date: Date.today.beginning_of_week..Date.today.end_of_week)
    @prepaid_weekly_sale_cnt = total_sell_weekly.where(sim_type: 'Prepaid').count
    @postpaid_weekly_sale_cnt = total_sell_weekly.where(sim_type: 'Postpaid').count

  end
end
