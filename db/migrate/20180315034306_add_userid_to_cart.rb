class AddUseridToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts,:user_id,:integer
    add_column :carts,:cart_items_count,:integer,default: 0
  end
end
