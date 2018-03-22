class CartItemsController < ApplicationController
    # before_action :authenticate_user!
    before_action :find_cart_item_id, except: [:update]  
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

        extend CommonHelper
        @cart = current_cart                
        #此錯誤為購物車無此商品
        if @cart.products.include?(@product)
            #將 product 轉hsah 且算出型號的庫存
            @product_size_quantity = @product.attributes[@size].to_i            
            if @quantity <= @product_size_quantity
                #找出 cart_item 
                @cart_item = @cart.cart_items.find_by(product_id: @product.id)
                #將text 轉 hash
                @cart_item_quantity = eval(@cart_item.quantity)
                #將size轉hash                
                #給予型號庫存
                @cart_item_quantity[eval(":"+@size)] = @quantity
                #更新庫存
                @cart_item.update_attributes(quantity: @cart_item_quantity.to_s)

                respond_to do |format|
                format.js { render "cart_item"}
                end                
            else
                flash.now[:warning] = "已超出#{@product.name}庫存！"
            end
        else
            flash.now[:alert] = "購物車無#{@product.name}！"
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
end
