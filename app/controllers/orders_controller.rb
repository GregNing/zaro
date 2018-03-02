class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_order_id_token, except: [:create]
  def create
    extend CommonHelper
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price
    if @order.save
        current_cart.cart_items.each do |cart_item|
          product_list = ProductList.new
          product_list.order = @order
          product_list.product_name = cart_item.product.name
          product_list.product_price = cart_item.product.price
          product_list.quantity = cart_item.quantity
          product_list.save
        end
      redirect_to order_path(@order.token),notice: "#{@order.billing_name} 訂單送出成功!"
    else
      render 'carts/checkout'
    end
  end
  def show    
    @product_lists = @order.product_lists
  end
  def pay_with_alipay      
      @order.set_payment_with!("alipay")
      @order.pay!
      redirect_to order_path(@order.token), notice: "使用支付宝成功完成付款"
  end

  def pay_with_wechat    
    @order.set_payment_with!("wechat")
    @order.pay!
    redirect_to order_path(@order.token), notice: "使用微信成功完成付款"
  end
  private
  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end
  def find_order_id_token
    @order = Order.find_by(token: params[:id])
  end
end
