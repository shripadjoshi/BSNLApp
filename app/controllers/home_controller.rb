class HomeController < ApplicationController
  def index
    q1_start = Date.today.beginning_of_year
    q1_end = (q1_start + 2.month).end_of_month

    q2_start = q1_start + 3.month
    q2_end = (q2_start + 2.month).end_of_month

    q3_start = q2_start + 3.month
    q3_end = (q3_start + 2.month).end_of_month

    q4_start = q3_start + 3.month
    q4_end = (q4_start + 2.month).end_of_month

    @yearly_sale = Sim.where(sell_date: q1_start..q4_end).order(:sell_date)

    start_month_date = Date.today.beginning_of_month
    end_month_date = Date.today.end_of_month

    month_sale = @yearly_sale.select{|sale| (sale.sell_date >= start_month_date && sale.sell_date <= end_month_date)}
    
    @prepaid_monthly_sale = month_sale.select{|sale| sale.sim_type == 'Prepaid'}
    @postpaid_monthly_sale = month_sale.select{|sale| sale.sim_type == 'Postpaid'}

    monthly_sale = month_sale.group_by{|data| [data.sell_date.to_date.strftime('%d %b, %Y'),data.sim_type]}

    today_date = Date.today.strftime('%d %b, %Y')
    
    daily_sale = @yearly_sale.select{|sale| sale.sell_date == Date.today}
    @prepaid_daily_sale = daily_sale.select{|sale| sale.sim_type == 'Prepaid'}
    @postpaid_daily_sale = daily_sale.select{|sale| sale.sim_type == 'Postpaid'}
    
    @prepaid_daily_sale_cnt = (monthly_sale[["#{today_date}", "Prepaid"]] ? monthly_sale[["#{today_date}", "Prepaid"]].count : 0)
    @postpaid_daily_sale_cnt = (monthly_sale[["#{today_date}", "Postpaid"]] ? monthly_sale[["#{today_date}", "Postpaid"]].count : 0)

    
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week

    @weekly_prepaid_sale = month_sale.select{|sale| sale.sim_type == 'Prepaid' && sale.sell_date >= start_date && sale.sell_date <= end_date}
    @weekly_postpaid_sale = month_sale.select{|sale| sale.sim_type == 'Postpaid' && sale.sell_date >= start_date && sale.sell_date <= end_date}

    @prepaid_monthly_sale = month_sale.select{|sale| sale.sim_type == 'Prepaid'}
    @postpaid_monthly_sale = month_sale.select{|sale| sale.sim_type == 'Postpaid'}

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

    @prepaid_qty_sale = []
    @postpaid_qty_sale = []

    q1_sale = @yearly_sale.select{|sale| (sale.sell_date >= q1_start && sale.sell_date <= q1_end)}.group_by{|x| x.sim_type}
    q2_sale = @yearly_sale.select{|sale| (sale.sell_date >= q2_start && sale.sell_date <= q2_end)}.group_by{|x| x.sim_type}
    q3_sale = @yearly_sale.select{|sale| (sale.sell_date >= q3_start && sale.sell_date <= q3_end)}.group_by{|x| x.sim_type}
    q4_sale = @yearly_sale.select{|sale| (sale.sell_date >= q4_start && sale.sell_date <= q4_end)}.group_by{|x| x.sim_type}

    @prepaid_qty_sale.push((q2_sale["Prepaid"] ? q2_sale["Prepaid"].count : 0))
    @postpaid_qty_sale.push((q2_sale["Postpaid"] ? q2_sale["Postpaid"].count : 0))

    @prepaid_qty_sale.push((q3_sale["Prepaid"] ? q3_sale["Prepaid"].count : 0))
    @postpaid_qty_sale.push((q3_sale["Postpaid"] ? q3_sale["Postpaid"].count : 0))

    @prepaid_qty_sale.push((q4_sale["Prepaid"] ? q4_sale["Prepaid"].count : 0))
    @postpaid_qty_sale.push((q4_sale["Postpaid"] ? q4_sale["Postpaid"].count : 0))

    @prepaid_qty_sale.push((q1_sale["Prepaid"] ? q1_sale["Prepaid"].count : 0))
    @postpaid_qty_sale.push((q1_sale["Postpaid"] ? q1_sale["Postpaid"].count : 0))

  end
end
