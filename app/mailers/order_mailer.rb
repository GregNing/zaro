class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    mail(to: to_custome_user(order) , subject: "[ZARO] 感謝您完成本次訂單，以下是您這次購物單明細 #{order.token}")    
  end
  def to_custome_user(order)
    @order       = order
    @user        = order.user
    @product_lists = @order.product_lists
  end
  def to_admin(order)
    to_user(order)
    "admin@greg.com"
  end
end
