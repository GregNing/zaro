class ProductsController < ApplicationController
    before_action :find_product_id,except: [:index, :create, :new]
    def index
        @products = Product.all.page(params[:page]).per(8)
    end

    def show
        
    end
    def add_to_cart
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
