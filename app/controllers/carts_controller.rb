class CartsController < ApplicationController
    skip_before_action :verify_authenticity_token,only: [:store_address]
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
    #取得店到店地址
    def store_address
        binding.pry
# var params = {
#     rtURL: 'http://localhost:3000/carts/store_address',
#     processID: token,  
# };

# var param = Object.keys(params).map(function(k) {
#     return encodeURIComponent(k) + '=' + encodeURIComponent(params[k])
# }).join('&')

# //Add authentication headers in URL
# var url = ['http://map.ezship.com.tw/ezship_map_web_2014.jsp', param].join('?');

# //Open window
# var OpenWindow = window.open(url,'電子地圖搜尋',config='height=650,width=780,location=no,left=350,top=50');
# OpenWindow.close();
    end
    private
    #取的相關購物車資訊
    def get_carts_into
        extend CommonHelper
        @cart = current_cart
        @cart_items = @cart.get_items
    end
    #將參數允許做串接動作
    def params_permit_for_ezship
        #processID 處理序號或訂單編號
        #stCate 取件門市通路代號
        #stCode 取件門市代號
        #stName 取件門市名稱
        #stAddr 取件門市地址
        #stTel 取件門市電話
        #webPara 網站所需額外判別資料
        params.permit(:processID , :stCate, :stCode, :stName, :stAddr, :stTel ,:webPara)
    end
end
