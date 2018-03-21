class ProductsController < ApplicationController
    before_action :find_product_id,except: [:index, :create, :new]
    def index
        @products = Product.order_position.page(params[:page]).per(8)
    end

    def show
        
    end
    def edit_size_quantity     
        case params[:size]
        when "S"
            @quantity = @product.s
        when "M"
            @quantity = @product.m
        when "L"
            @quantity = @product.l
        end               
    end
    #直接購買或是加入購物車
    def buy_or_add_to_cart        
        extend CommonHelper        
        @size = params[:size].to_s        
        if @size != "M" && @size != "L" && @size != "S"                    
            redirect_back fallback_location: root_path,warning: "請選擇尺寸!"            
            return
        end
        @quantity = params[:quantity].to_i
        @size = eval(":#{@size.to_s.downcase}")
        case params[:commit]
        #加入購物車
        when "add_to_cart"            
            if current_cart.add_product_to_cart!(@product,@size,@quantity)
                flash.now[:notice] = "已將#{@product.name} #{@size}號加入購物車"
            else
                flash.now[:warning] = "已售完#{@product.name}"
            end
        #直接購買
        when "buy_product"
            #S號庫存
            if @size == "S" && @quantity > @poduct.s
                redirect_back fallback_location: root_path,warning: "您下單S號數量已超出庫存量!"
            #M號庫存
            elsif @size == "M" && @quantity > @poduct.m
                redirect_back fallback_location: root_path,warning: "您下單M號數量已超出庫存量!"
            #L號庫存
            elsif @size == "L" && @quantity > @poduct.l
                redirect_back fallback_location: root_path,warning: "您下單L號數量已超出庫存量!"
            end
            item = current_cart.add_product_to_cart!(@product,@size,@quantity)
            redirect_to checkout_cart_path(item_ids:[item.id])
        end
    end
    def add_to_cart
        extend CommonHelper
        current_cart.add_product_to_cart!(@product)
        redirect_back fallback_location: root_path, notice: "#{@product.name}已加入購物車"     
    end
    private
    def find_product_id
        @product = Product.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name,:description,:quantity,:price)
    end
    #過濾字串
    def validate_search_key
        @query = params[:query].gsub(/\|\'|\/|\?/, "") if params[:query].present?
    end    
end
