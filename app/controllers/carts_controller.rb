class CartsController < ApplicationController    
    def index
        extend CommonHelper
        @cart_items = current_cart.get_items
    end
    
    def operations
        if params[:delete_item].present? # 用户删除单个课程
        delete_item
        elsif params[:delete_items].present? # 用户删除多个课程
        delete_items
        elsif params[:checkout].present? # 用户进行结算
        do_checkout
        end
    end
    #刪除單一商品
    def delete_item        
        #若存在此商品轉成陣列
        @item_ids = params[:item_ids].present? ? params[:item_ids].to_a : []
        @cart_item = CartItem.find(params[:delete_item])
        @cart_item.destroy
        @item_ids.delete(params[:delete_item])
        flash.now[:notice] = "#{@cart_item.product.name} 已從購物車移除!"
        render "carts/delete_item" 
    end
    #結算頁面
    def checkout
        @order = Order.new
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

    # 進行結算
    def do_checkout
        unless params[:item_ids].present?
        flash[:warning] = "尚未挑選任何商品"
        redirect_to carts_path
        else
        redirect_to checkout_cart_path(item_ids: params[:item_ids])
        end
    end    
end
