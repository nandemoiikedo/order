# frozen_string_literal: true

# 範囲を指定してその期間の売上そう合計を出すコード

# OrdersReportクラスは、指定された期間内の注文の売上合計を計算するクラスです。
class OrdersReport
  def initialize(orders, date_range)
    @orders = orders
    @date_range = date_range
  end

  def total_sales_within_date_range
    total_sales(order_with_range)
  end

  private

  def total_sales(orders)
    orders.map(&:amount).inject(0, :+)
  end

  def order_with_range
    @orders.select do |order|
      order.placed_between?(@date_range)
    end
  end
end

# DateRangeクラスは、開始日と終了日を範囲として持ち、その範囲内の日付をチェックします。
class DateRange
  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def include?(date)
    (start_date..end_date).cover? date
  end
end

# Orderクラスは注文情報を表現し、指定された期間内に注文が行われたかどうかを判定します。
class Order
  attr_accessor :amount, :placed_at

  def initialize(amount:, placed_at:)
    @amount = amount
    @placed_at = placed_at
  end

  def placed_between?(date_range)
    date_range.include?(placed_at)
  end
end
