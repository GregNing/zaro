class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :warning  
  extend CommonHelper
  #如果你要在 controller 和 view 都能拉現在的購物車，
  #必須要用 helper_method 宣告這是一個 controller 級的 helper。
  # helper_method :current_cart
  # def current_cart
  #   @current_cart ||= find_cart
  # end
  protected
  def require_admin
      unless current_user && current_user.admin?
        redirect_to root_path, warning: "只允許管理員進入!"
      end
  end
  # def find_cart
  #     cart = Cart.find_by(id: session[:cart_id])
  #     if cart.blank?
  #       cart = Cart.create
  #     end
  #     session[:cart_id] = cart.id
  #     return cart
  # end
end
