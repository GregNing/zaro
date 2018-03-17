# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  product_id :integer
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  size       :string
#

class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :product

    def change_quantity!(quantity)        
        self.quantity += quantity
        self.save!        
    end
    #輸入 size 回傳成 quantity(庫存量) ex: input "S" puts 5
    def size_quantity_to_change(size)
        #轉所需的hash
        @size = eval(":#{size.to_s.downcase}")
        @result = 0
        if self.quantity.present?
            #將庫存量 text 轉 hash
            @quantity = eval(self.quantity)
            #將size 也轉為hash
            @result = @quantity[@size]
        end
        return @result
    end
end
