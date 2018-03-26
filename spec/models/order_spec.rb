require 'rails_helper'
RSpec.describe Order, type: :model do
    #新建一筆新訂單
    describe "#add new Order" do
        context "new order" do
            #use let to new order
            #新增訂單
            let(:order) { Order.new }
            #取得使用者
            let(:user) { User.first }
            #購物車
            let(:cart) { Cart.first }

            it "is invalid order" do
            order.total = 5
            # productList_create
            order.billing_name = "test_billing_name"
            order.billing_address = "test_billing_address"
            order.shipping_name = "test_shipping_name"
            order.shipping_address = "test_shipping_address"            
            order.user = user            
            order.save!
            byebug
            cart.cart_items.includes(:product).each { |cart_item|  order.productList_create!(cart_item) }
            cart.clean!
            expect(order).to be_valid            
            end
        end
    end
end