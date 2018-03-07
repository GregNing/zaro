class Admin::ProductsController < Admin::AdminsController
    before_action :find_product, except: [:index, :new, :create]

    def index
        #使用 includes 解決的 N+1 問題        
        @products = Product.includes(:category).order_position.page(params[:page]).per(5)      
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
        @products = Product.includes(:category).order_position.page(params[:page]).per(5)
        render "index"
    end
    def move_lower        
        @product.move_lower
        @products = Product.includes(:category).order_position.page(params[:page]).per(5)
        render "index"
    end
    
    private
    def product_params
        # params.require(:product).permit(:name, :description, :price, :image,:category_id,
        #                                 sizes_attributes: [:s,:m,:l] )
        params.require(:product).permit(:name, :description, :price, :image,:category_id,
                                        :s,:m,:l)        
    end
    def find_product
        @product = Product.find(params[:id])
    end
end
