class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :warning
  
  protected
  def require_admin
      unless current_user && current_user.admin?
        redirect_to root_path, warning: "只允許管理員進入!"
      end
  end
end
