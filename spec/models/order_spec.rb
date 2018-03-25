require 'rails_helper'
RSpec.describe Order, type: :model do
    #新建一筆新訂單
    describe "#add new Order" do
        context "new order" do
            #use let to new order
            let(:order) { Order.new }
            it "is invalid order" do
            order.total = 5
    # @order = Order.new(order_params)
    # @order.user = current_user
    # @order.total = current_cart.total_price
    # if @order.save
    #     current_cart.get_items.each do |cart_item|
    #       product_list = ProductList.new
    #       product_list.order = @order
    #       product_list.product_name = cart_item.product.name
    #       product_list.product_price = cart_item.product.price
    #       product_list.quantity = cart_item.quantity
    #       product_list.save
    #     end
    #   current_cart.clean!
            expect(order.total).to eq(5)
            end

        end
    end
end