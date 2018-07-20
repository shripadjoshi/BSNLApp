class HomeController < ApplicationController
  def index
    total_sell_today = Sim.where(sell_date: Date.today)
    @prepaid_daily_sale_cnt = total_sell_today.where(sim_type: 'Prepaid').count
    @postpaid_daily_sale_cnt = total_sell_today.where(sim_type: 'Postpaid').count
    
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    @prepaid_sale = []
    @postpaid_sale = []
    @dates = []
    for i in start_date..end_date
      @dates.push("#{i.strftime('%d %b, %Y')}")
      @prepaid_sale.push((Sim.where(sell_date: i).where(sim_type: 'Prepaid').count).to_i)
      @postpaid_sale.push((Sim.where(sell_date: i).where(sim_type: 'Postpaid').count).to_i)
    end

  end
end
