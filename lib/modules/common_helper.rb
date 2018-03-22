module CommonHelper      
  def current_cart    
    if current_user
      @current_cart ||= find_user_cart
    else
      @current_cart ||= find_session_cart
    end    
  end
  #找到用戶專屬購物車已經登入狀態
  def find_user_cart
    #判斷使用者是否已有購物車
    cart = current_user.cart    
    if cart.nil?
      #如果使用者購物車是空的就建立一筆新的購物車
      cart = find_session_cart      
      current_user.cart = cart
    else
      #在此判斷在尚未登入情況下已經有將某物品加至購物車中 現在要新增到原使用者的購物車內
      session_cart = Cart.find_by(id: session[:cart_id])
      #如果購物車(尚未登入前)已有商品 在這會重新加入
      if session_cart.present?
        session_cart.cart_items.includes(:product).each do | item |          
          eval(item.quantity).each do | key , value |            
            cart.add_product_to_cart!(item.product ,key , value)
          end          
        end          
          session_cart.clean! 
      end
    end
    return cart
  end

  #尚未登入狀態 將資訊存在session裡面找一個臨時購物車 ||相似於 ||= 
  def find_session_cart
     cart = Cart.find_by(id: session[:cart_id]) || find_empty_cart
     session[:cart_id] = cart.id        
      return cart    
  end

  #空購物車建置
  def find_empty_cart
    carts = Cart.find_by(user_id: nil)
    if carts.blank?          
      carts = Cart.create
    end
    return carts
  end
end