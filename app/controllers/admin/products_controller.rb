class Admin::ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :find_product, except: [:index, :new, :create]
    layout "admin"
    require 'pry'
    def index
        @products = Product.all.order_position.page(params[:page]).per(8)
    end
    def show
        
    end
    def new
        @product = Product.new
    end
    def create
        @product = Product.new(product_params)
        @product.user = current_user        
        if @product.save            
            redirect_to admin_products_path,notice: "新增#{@product.name}成功!"
        else
            render :new
        end        
    end
    def edit
        
    end
    def update
        if @product.update(product_params)
            redirect_to admin_products_path,notice: "編輯#{@product.name}成功"
        else
            render :edit
        end
    end
    def destroy
        text = @product
        @product.destroy
        redirect_back fallback_location: root_path, alert: "已刪除#{text.name}商品!"
    end

    def move_higher        
        @product.move_higher
        
        redirect_back fallback_location: root_path, notice: "#{@product.name}向上移動成功!"
    end
    def move_lower        
        @product.move_lower
        redirect_back fallback_location: root_path, notice: "#{@product.name}向下移動成功!"
    end
    
    private
    def product_params
        params.require(:product).permit(:name, :description, :price, :quantity, :image)        
    end
    def find_product
        @product = Product.find(params[:id])
    end
end
