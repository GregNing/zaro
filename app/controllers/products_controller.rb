class ProductsController < ApplicationController
    before_action :find_product_id,except: [:index, :create, :new]
    def index
        @products = Product.all.page(params[:page]).per(8)
    end

    def show
        
    end
    private
    def find_product_id
        @product = Product.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name,:description,:quantity,:price)
    end
end
