class HomeController < ApplicationController
  def index
    start_month_date = Date.today.beginning_of_month
    end_month_date = Date.today.end_of_month
    monthly_sale = Sim.where(sell_date: start_month_date..end_month_date)
                             .order(:sell_date)
                             .group_by{|data| [data.sell_date.to_date.strftime('%d %b, %Y'),data.sim_type]}
    
    today_date = Date.today.strftime('%d %b, %Y')
    @prepaid_daily_sale_cnt = (monthly_sale[["#{today_date}", "Prepaid"]] ? monthly_sale[["#{today_date}", "Prepaid"]].count : 0)
    @postpaid_daily_sale_cnt = (monthly_sale[["#{today_date}", "Postpaid"]] ? monthly_sale[["#{today_date}", "Postpaid"]].count : 0)

    
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    @prepaid_sale = []
    @postpaid_sale = []
    @dates = []
    
    for i in start_date..end_date
      @prepaid_sale << (monthly_sale[["#{i.strftime('%d %b, %Y')}", "Prepaid"]] ? monthly_sale[["#{i.strftime('%d %b, %Y')}", "Prepaid"]].count : 0)
      @postpaid_sale << (monthly_sale[["#{i.strftime('%d %b, %Y')}", "Postpaid"]] ? monthly_sale[["#{i.strftime('%d %b, %Y')}", "Postpaid"]].count : 0)
      @dates.push("#{i.strftime('%d %b, %Y')}")
    end

    @prepaid_month_sale = []
    @postpaid_month_sale = []
    @month_dates = []

    for i in start_month_date..end_month_date
      @prepaid_month_sale << (monthly_sale[["#{i.strftime('%d %b, %Y')}", "Prepaid"]] ? monthly_sale[["#{i.strftime('%d %b, %Y')}", "Prepaid"]].count : 0)
      @postpaid_month_sale << (monthly_sale[["#{i.strftime('%d %b, %Y')}", "Postpaid"]] ? monthly_sale[["#{i.strftime('%d %b, %Y')}", "Postpaid"]].count : 0)
      @month_dates.push("#{i.strftime('%d %b, %Y')}")
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

    q1_sale = Sim.where(sell_date: q1_start..q1_end).group(:sim_type).count
    q2_sale = Sim.where(sell_date: q2_start..q2_end).group(:sim_type).count
    q3_sale = Sim.where(sell_date: q3_start..q3_end).group(:sim_type).count
    q4_sale = Sim.where(sell_date: q4_start..q4_end).group(:sim_type).count

    @prepaid_qty_sale.push((q2_sale["Prepaid"] ? q2_sale["Prepaid"] : 0))
    @postpaid_qty_sale.push((q2_sale["Postpaid"] ? q2_sale["Postpaid"] : 0))

    @prepaid_qty_sale.push((q3_sale["Prepaid"] ? q3_sale["Prepaid"] : 0))
    @postpaid_qty_sale.push((q3_sale["Postpaid"] ? q3_sale["Postpaid"] : 0))

    @prepaid_qty_sale.push((q4_sale["Prepaid"] ? q4_sale["Prepaid"] : 0))
    @postpaid_qty_sale.push((q4_sale["Postpaid"] ? q4_sale["Postpaid"] : 0))

    @prepaid_qty_sale.push((q1_sale["Prepaid"] ? q1_sale["Prepaid"] : 0))
    @postpaid_qty_sale.push((q1_sale["Postpaid"] ? q1_sale["Postpaid"] : 0))

  end
end
