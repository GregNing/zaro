class Admin::UsersController < Admin::AdminsController
    before_action :find_user_id,except: [:index, :new, :create]    
    def index
        @users = User.page(params[:page]).per(10)
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(params_user)
        if @user.save
            redirect_to admin_users_path , notice: "新增#{@user.email}成功"
        else
            render :new
        end
    end
    def edit
        
    end
    def update
        if @user.update_attributes(params_user)
            redirect_to admin_users_path , notice: "修改#{@user.email}成功"
        else
            render :eidt
        end
    end
    def destroy
        usermail = @user.email
        @user.destroy
        redirect_back fallback_location: root_path, alert: "已刪除#{usermail}帳號!"
    end
    private
    def find_user_id
        @user = User.find(params[:id])
    end
    def params_user
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
end
