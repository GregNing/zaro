class OrderMailer < ApplicationMailer
  #訂單成功通知信
    def notify_order_placed(order)
    mail(to: to_custome_user(order) , subject: "[ZARO] 感謝您完成本次訂單，以下是您這次購物單明細 #{order.token}")    
  end
  #取消訂單發送
  def apply_cancel(order)
    mail(to: to_admin(order) , subject: "[ZARO] 用戶#{order.user.email}申請取消訂單 #{order.token}")
  end
  #出貨通知信
  def notify_ship(order)
    to_custome_user(order)
    mail(to: @user.email, subject: "[ZARO] 您的訂單 #{order.token}已出貨")
  end
  #取消訂單 admin
  def notify_cancel(order)
    to_custome_user(order)
    mail(to: @user.email, subject: "[ZARO] 您的訂單 #{order.token}已取消")
  end
  
  def to_custome_user(order)
    @order       = order
    @user        = order.user
    @product_lists = @order.product_lists
  end
  def to_admin(order)
    to_custome_user(order)
    "admin@greg.com"
  end
end
