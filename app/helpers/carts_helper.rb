module CartsHelper
    def render_cart_total_price(cart)
        # sum = 0
        # cart.cart_items.each do |cart_item|
        #     if cart_item.product.price.present?
        #         sum = sum + cart_item.quantity * cart_item.product.price
        #     end
        # end
        # sum
        cart.total_price
    end
    #算點數到第2位
    def render_calculate_total_price(price)        
        sprintf("%2.1f", price)
    end  
end
