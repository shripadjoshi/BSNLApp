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

    start_month_date = Date.today.beginning_of_month
    end_month_date = Date.today.end_of_month
    @prepaid_month_sale = []
    @postpaid_month_sale = []
    @month_dates = []
    for i in start_month_date..end_month_date
      @month_dates.push("#{i.strftime('%d %b, %Y')}")
      @prepaid_month_sale.push((Sim.where(sell_date: i).where(sim_type: 'Prepaid').count).to_i)
      @postpaid_month_sale.push((Sim.where(sell_date: i).where(sim_type: 'Postpaid').count).to_i)
    end

    @quarter = ['Q1 (Apr-June)', 'Q2 (July-Sept)', 'Q3 (Oct-Dec)', 'Q4 (Jan-Mar)']
    
    q1_start = Date.today.beginning_of_year
    q1_end = (q1_start + 2.month).end_of_month

    q2_start = q1_start + 3.month
    q2_end = (q2_start + 2.month).end_of_month

    q3_start = q2_start + 3.month
    q3_end = (q3_start + 2.month).end_of_month

    q4_start = q3_start + 3.month
    q4_end = (q4_start + 2.month).end_of_month

    @prepaid_qty_sale = []
    @postpaid_qty_sale = []

    @prepaid_qty_sale.push((Sim.where(sell_date: q2_start..q2_end).where(sim_type: 'Prepaid').count).to_i)
    @postpaid_qty_sale.push((Sim.where(sell_date: q2_start..q2_end).where(sim_type: 'Postpaid').count).to_i)

    @prepaid_qty_sale.push((Sim.where(sell_date: q3_start..q3_end).where(sim_type: 'Prepaid').count).to_i)
    @postpaid_qty_sale.push((Sim.where(sell_date: q3_start..q3_end).where(sim_type: 'Postpaid').count).to_i)

    @prepaid_qty_sale.push((Sim.where(sell_date: q4_start..q4_end).where(sim_type: 'Prepaid').count).to_i)
    @postpaid_qty_sale.push((Sim.where(sell_date: q4_start..q4_end).where(sim_type: 'Postpaid').count).to_i)

    @prepaid_qty_sale.push((Sim.where(sell_date: q1_start..q1_end).where(sim_type: 'Prepaid').count).to_i)
    @postpaid_qty_sale.push((Sim.where(sell_date: q1_start..q1_end).where(sim_type: 'Postpaid').count).to_i)

  end
end
