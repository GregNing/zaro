# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :products, through: :cart_items,source: :product
    #新增商品至購物車
    def add_product_to_cart!(product , size ,quantity)
        if products.include?(product)
            @cart_item = cart_items.find_by(product_id: product.id ,size: size)
        else
            @cart_item = cart_items.build
            @cart_item.product = product
        end
        @cart_item.change_quantity!(quantity) if @cart_item.quantity + quantity <= product.quantity
        # product_cart = cart_items.build
        # product_cart.product = product
        # product_cart.quantity = 1
        # product_cart.save
    end
    def total_price
      sum = 0
      cart_items.each do |cart_item|
        if cart_item.product.price.present?
          sum += cart_item.quantity * cart_item.product.price
        end
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
