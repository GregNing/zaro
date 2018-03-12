class ProductsController < ApplicationController
    before_action :find_product_id,except: [:index, :create, :new]
    def index
        @products = Product.order_position.page(params[:page]).per(8)
    end

    def show
        
    end
    def add_to_cart
        extend CommonHelper
        #不可重複加入商品
        # if !current_cart.products.include?(@product)
        #     current_cart.add_product_to_cart(@product)    
        #     redirect_back fallback_location: root_path, notice: "已將#{@product.name}加入購物車"
        # else
        #     redirect_back fallback_location: root_path, warning: "#{@product.name}購物車已有此商品!"
        # end
        current_cart.add_product_to_cart(@product)
        redirect_back fallback_location: root_path, notice: "#{@product.name}已加入購物車"     
    end
    private
    def find_product_id
        @product = Product.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name,:description,:quantity,:price)
    end
end
