module CommonHelper      
  def current_cart    
    if current_user
      @current_cart ||= find_user_cart
    else
      @current_cart ||= find_session_cart
    end    
  end
  #  def find_cart
  #    cart = Cart.find_by(id: session[:cart_id])
  #    if cart.blank?
  #      cart = Cart.create
  #    end
  #    session[:cart_id] = cart.id
  #    return cart
  #  end
  
  #找到用戶專屬購物車已經登入狀態
  def find_user_cart
    cart = current_user.cart
    if cart.nil?
      cart = find_session_cart
      #如果使用者購物車是空的就建立一筆新的購物車      
      current_user.cart = cart
    end
    session_cart = find_session_cart
    # 將臨時購物車加入
    unless session_cart.empty?
      cart.merge!(session_cart)
      session_cart.clean!
    end    
  end

  #將資訊存在session裡面找一個臨時購物車 ||相似於 ||= 
  def find_session_cart
     cart = Cart.find_by(id: session[:cart_id])     
     if cart.blank?
       cart = Cart.create
     end
     session[:cart_id] = cart.id        
      return cart    
  end

end