# == Schema Information
#
# Table name: carts
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  cart_items_count :integer          default(0)
#

class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :products, through: :cart_items,source: :product
    
    #找出所有購物車商品
    def get_items
        @cart_items = cart_items.includes(:product)
    end
    #新增商品至購物車
    def add_product_to_cart!(product , size ,quantity)
        #此商品已經存在夠物車 增加數量
        if products.include?(product)
            @cart_item = cart_items.find_by(product_id: product.id)
        else
            @cart_item = cart_items.build
            @cart_item.product = product            
        end
        
        #在此判斷size庫存量        
        sizequantity = product.attributes[size.to_s]
        #size_quantity_to_change會回傳該size的庫存量        
        return (@cart_item.size_quantity(size) + quantity <= sizequantity) ? @cart_item.change_quantity!(size,quantity)  : false
    end
    #更新購物車商品
    def update_cart_items!(product,size,quantity)
        @result = false
        if products.include?(product)
            #將 product 轉hsah 且算出型號的庫存
            @product_size_quantity = product.attributes[size].to_i            
            if quantity <= @product_size_quantity                
                #找出 cart_item 
                @cart_item = cart_items.find_by(product_id: product.id)                
                #將text 轉 hash
                @cart_item_quantity = eval(@cart_item.quantity)
                #將size轉hash                
                #給予型號庫存
                @cart_item_quantity[eval(":"+size)] = quantity
                #更新庫存
                @cart_item.update_attributes(quantity: @cart_item_quantity.to_s)
                @result = true
            end
        end
        return @result
    end
    #計算總共金額
    def total_price
        sum = 0.0
        quantity = 0        
        cart_items.each do |cart_item|
            if cart_item.product.price.present?
                #轉 hash                
                eval(cart_item.quantity).each { | k , v| quantity += v }                
                sum += quantity * cart_item.product.price
                quantity= 0
            end
        end
        sum.round(3)
    end
    #計算總共幾件在購物車
    def total_items
        sum = 0
        @cartitem = Hash.new
        cart_items.each do |cart_item|
            @cartitem = eval(cart_item.quantity)
            @cartitem.each { | k , v |  sum += v }
        end
        sum
    end 

    #將購物車清空
    def clean!
        cart_items.destroy_all
    end
    def clear_cart_item!(product)
        cart_item = cart_items.find_by(product: product)
        cart_item.destroy
    end
end
