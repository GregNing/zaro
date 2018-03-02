class CartsController < ApplicationController
    before_action :authenticate_user!
    def checkout
        @order = Order.new
    end
    def clean
        extend CommonHelper
        current_cart.clean!
        redirect_to carts_path, warning: "購物車已經清空!"
    end
end
