class CartItemsController < ApplicationController
    before_action :authenticate_user!
    def update
        extend CommonHelper
        @cart = current_cart
        @cart_item = @cart.cart_items.find_by(product_id: params[:id])
        if  @cart_item.product.quantity >= cart_items_params[:quantity].to_i
            @cart_item.update(cart_items_params)
            redirect_back fallback_location: root_path, notice: "已成功更新#{@cart_item.product.name}數量"
        else
            redirect_back fallback_location: root_path, warning: "#{@cart_item.product.name}數量不足無法加入購物車"
        end
    end
    def destroy
        byebug
        @cart_item = CartItem.find(params[:id])        
        # extend CommonHelper
        # @cart = current_cart
        # @cart_item = @cart.cart_items.find_by(product_id: params[:id])
        @product = @cart_item.product
        @cart_item.destroy

        redirect_back fallback_location: root_path, warning: "已成功將#{@product.name}從購物車移除"    
    end
    private
    def cart_items_params
        #在這只需要更新庫存量
        params.require(:cart_item).permit(:quantity)
    end
end
