class CartItemsController < ApplicationController
    # before_action :authenticate_user!
    before_action :find_cart_item_id, except: [:update]
    before_action :get_carts_into
    # require 'common_helper'
    # require File.expand_path("../lib/modules/common_helper", __FILE__)  
    respond_to :html, :js
    def update
        #判斷是否為空
        if params[:size].blank? || params[:quantity].blank? || params[:quantity].to_i == 0 ||
           (params[:size] != "s" && params[:size] != "m" && params[:size] != "l")                       
            render "cart_items/error"
            return
        end
        #要修改的庫存量
        @quantity = params[:quantity].to_i
        #szie
        @size = params[:size].to_s
        #產品代號
        @product = Product.find(params[:id])

        if @cart.update_cart_items!(@product,@size,@quantity)
            respond_to do |format|
            format.js { render "cart_item"}
            end                
        else
            flash.now[:warning] = "購物車無#{@product.name}或是商品庫存不足！"
        end
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
    def get_carts_into
        extend CommonHelper
        @cart = current_cart
        @cart_items = @cart.get_items
    end    
end
