# 範囲を指定してその期間の売上そう合計を出すコード

class OrdersReport
  def initialize(orders, date_range)
    @orders = orders
    @date_range = date_range
  end

  def total_sales_within_date_range
    orders_within_range.map(&:amount).inject(0) do |sum, order|
      sum + order
    end
  end

  private

  def order_with_range
    @orders.select do |order|
      order.placed_between?(@date_range)
    end
  end
end

class DateRage < Struct.new(:start_date, :end_date)
  def include?(date)
    (start_date..end_date).cover? date
  end
end

class Order < OpenStruct
  def placed_between?(date_range)
    date_range.include?(placed_at)
  end
end