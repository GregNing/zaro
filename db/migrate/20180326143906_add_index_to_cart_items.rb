class AddIndexToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_index :cart_items, :product_id
    add_index :cart_items, :cart_id
    add_index :categories, :user_id
    add_index :product_lists,:order_id
    add_index :orders,:user_id
    add_index :products,:category_id
  end
end
