class CartItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_cart_item_id, except: [:update]
    def update
        
        if params[:size].blank? || params[:quantity].blank? || params[:quantity].to_i == 0 ||
           (params[:size] != "s" && params[:size] != "m" && params[:size] != "l")            
            render "cart_items/error"
        end
        
        @quantity = params[:quantity].to_i
        #轉hash
        @size = eval(":"+params[:size].to_s)
        extend CommonHelper
        @cart = current_cart
        # @cart_item = @cart.cart_items.includes(:product).find_by(product_id: params[:id])
        
        if @cart.add_product_to_cart!(Product.find(params[:id]),@size,@quantity)
            # redirect_back fallback_location: root_path, notice: "已成功更新#{@cart_item.product.name}數量"
        else
            
        end
        # if  @cart_item.product.quantity >= cart_items_params[:quantity].to_i
        #     @cart_item.update(cart_items_params)
        #     redirect_back fallback_location: root_path, notice: "已成功更新#{@cart_item.product.name}數量"
        # else
        #     redirect_back fallback_location: root_path, warning: "#{@cart_item.product.name}數量不足無法加入購物車"
        # end
    end
    #增加數量在商品 show畫面
    def increase
        
    end
    #減少數量在商品 show畫面
    def decrease
        
    end    
    def destroy                
        @product = @cart_item.product
        @cart_item.destroy
        flash.now[:notice] = "已成功將#{@product.name}從購物車移除"
        render 'cart_items/delete_item'
    end
    private
    def find_cart_item_id
        @cart_item = CartItem.find(params[:id])
    end
    def cart_items_params
        #在這只需要更新庫存量
        params.require(:cart_item).permit(:quantity)
    end
end
