class Admin::OrdersController < Admin::AdminsController
    before_action :find_order_id,except: [:index]

    def index        
        @orders = Order.order("id DESC")        
    end
    def show
        @product_lists = @order.product_lists
    end
    def ship
        @order.ship!
        OrderMailer.notify_ship(@order).deliver!     
        redirect_back fallback_location: root_path, notice: "已出貨#{@order.token}!"
    end

    def shipped
        @order.deliver!
        redirect_back fallback_location: root_path, notice: "設為#{@order.token}已出貨成功!"        
    end

    def cancel
        @order.cancel_order!
        OrderMailer.notify_cancel(@order).deliver!
        redirect_back fallback_location: root_path, warning: "取消#{@order.token}訂單!"        
    end

    def return        
        @order.return_good!
        redirect_back fallback_location root_path, warning: "退貨#{@order.token}成功!"
    end
    private
    def find_order_id
        @order = Order.find(params[:id])
    end
end
