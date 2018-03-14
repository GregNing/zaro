module CommonHelper      
  def current_cart
    if current_user?
      @current_cart ||= find_user_cart
    else
      @current_cart ||= find_session_cart
    end    
  end
  def find_cart
      cart = Cart.find_by(id: session[:cart_id])
      if cart.blank?
        cart = Cart.create
      end
      session[:cart_id] = cart.id
      return cart
  end
  def find_user_cart
    
  end
  #將資訊存在session裡面
  def find_session_cart
     cart = Cart.find_by(id: session[:cart_id])
     if cart.blank?
       cart = Cart.create
     end
     session[:cart_id] = cart.id
  end
end