module CommonHelper      
  def current_cart
    @current_cart ||= find_cart
  end
  def find_cart
      cart = Cart.find_by(id: session[:cart_id])
      if cart.blank?
        cart = Cart.create
      end
      session[:cart_id] = cart.id
      return cart
  end
end