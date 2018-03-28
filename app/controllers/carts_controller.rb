class CartsController < ApplicationController
    #加入carts 相關資訊
    before_action :get_carts_into
    def index
    end
    
    def operations        
        #多選刪除
        if params[:delete_items].present?
        delete_items
        #結算
        elsif params[:checkout].present?
        redirect_to checkout_cart_path(item_ids: params[:item_ids])
        end
    end
    #結算頁面
    def checkout         
        if params[:item_ids].present?
        @items = CartItem.where(id: params[:item_ids])
        @order = Order.new        
        else
            flash.now[:alert] = "尚未挑選任何商品!"
            redirect_back fallback_location: root_path            
        end
    end

    #刪除多個商品 多選
    def delete_items
        if params[:item_ids].present?
            CartItem.where(id: params[:item_ids]).destroy_all
            flash[:notice] = "已刪除 #{params[:item_ids].count} 件商品"
        else
            flash[:warning] = "尚未挑選任何商品"        
        end
        respond_to do |format|
        format.js { render "cart_items/cart_item"}
        end      
    end
    private
    #取的相關購物車資訊
    def get_carts_into
        extend CommonHelper
        @cart = current_cart
        @cart_items = @cart.get_items
    end
end
