# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  product_id :integer
#  quantity   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartItem < ApplicationRecord
    belongs_to :cart, counter_cache: true
    belongs_to :product

    #修改購物車商品存量
    def change_quantity!(size,quantity)
        #宣告一個 hash變數
        @quantity = Hash.new
        if self.quantity.blank?            
            #新增size 庫存 ex m: 5
            @quantity[size] = quantity.to_i            
            #再將hash轉成string 存進quantity
            self.quantity = @quantity.to_s            
            self.save!
        else
            #取出庫存轉成hash
            @quantity = eval(self.quantity)
            if @quantity[size].blank?
                @quantity[size] = quantity
            else                    
                #取出 value 將原先件數 + 上限要加入的件數
                @quantity[size] = @quantity[size].to_i + quantity.to_i
            end            
            #將hash轉為字串存入 使用update_attributes 不跳過驗證方式
            self.update_attributes(quantity: @quantity.to_s)
        end
    end
    #輸入 size 回傳成 quantity(庫存量) ex: input "S" puts 5 
    def size_quantity_to_change(size)        
        #轉所需的hash
        @size = eval(":#{size.to_s.downcase}")
        @result = 0
        if self.quantity.present?            
            #將庫存量 text 轉 hash
            @quantity = eval(self.quantity)
            #將size 也轉為hash 在此判斷是否已存在此size
            @result = @quantity[@size].blank? ? 0 : @quantity[@size]
        end                
        return @result
    end
    #計算購物車內的物件有多少金額
    def cartitem_total_price
        @sum = 0.0
        @quantity = 0
        eval(self.quantity).each { | k , v| @quantity += v }        
        @price = self.product.price
        @sum = @quantity * @price
        return @sum.round(3)
    end    
end
