class CartsController < ApplicationController    
    def index
        extend CommonHelper
        @cart_items = current_cart.get_items
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
 
    def clean
        extend CommonHelper
        current_cart.clean!
        redirect_to carts_path, warning: "購物車已經清空!"
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
end
