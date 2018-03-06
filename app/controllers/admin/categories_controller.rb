class Admin::CategoriesController < Admin::AdminsController
    before_action :find_category_id, only: [:edit, :update]
    def index
        @categories = Category.all
    end
    def new
        @category = Category.new
    end
    def create
        @category = Category.new(categories_params)
        @category.user = current_user
        if @category.save
            redirect_to :admin_categories_path,notice: "新增#{@category.name}成功"
        else
            render :new
        end
    end
    def edit        
    end
    def update
        if @category.update(categories_params)
             redirect_to :admin_categories_path,notice: "修改#{@category.name}成功"
        else
            render :edit
        end
    end
    def destroy
         @category.destroy
         redirect_back fallback_location: root_path, alert: "已刪除#{@category.name}商品種類!"
    end
    private
    def categories_params
        params.require(:categories).permit(:name)
    end    
    def find_category_id
        @category = Category.find(params[:id])
    end
end
