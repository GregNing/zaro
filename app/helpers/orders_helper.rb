module OrdersHelper
    def render_order_paid_state(order)
      if order.is_paid?
        "已付款"
      else
        "未付款"
      end
    end
    def str_to_date(time)
        time.created_at.strftime("%Y/%m/%d")
    end
    def str_to_datetime(time)
        time.created_at.strftime("%Y/%m/%d %I:%M%p")
    end
end
