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
        
        if products.include?(product)
            @cart_item = cart_items.find_by(product_id: product.id)
        else
            @cart_item = cart_items.build
            @cart_item.product = product            
        end
        
        #在此判斷size庫存量        
        sizequantity = 0
        if size == :s
            sizequantity = product.s
        elsif size == :m
            sizequantity = product.m
        elsif size == :l
            sizequantity = product.l
        end        
        #size_quantity_to_change會回傳該size的庫存量        
        return (@cart_item.size_quantity(size) + quantity <= sizequantity) ? @cart_item.change_quantity!(size,quantity)  : false
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
