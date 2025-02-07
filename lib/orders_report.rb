# 範囲を指定してその期間の売上そう合計を出すコード

class OrdersReport
  def initialize(orders, start_date, end_date)
    @orders = orders
    @start_date = start_date
    @end_date = end_date
  end

  def total_sales_within_date_range
    orders_within_range = @orders.select do |order|
      order.placed_at >= @start_date && order.placed_at <= @end_date
    end

    orders_within_range.inject(0) do |sum, order|
      sum + order.amount
    end
  end
end

class Order < OpenStruct
end