class Cart < ApplicationRecord
    has_many :cart_items
    has_many :products, through: :cart_items,source: :product
    def add_product_to_cart(product)
        product_cart = cart_items.build
        product_cart.product = product
        product_cart.quantity = 1
        product_cart.save
    end
end
