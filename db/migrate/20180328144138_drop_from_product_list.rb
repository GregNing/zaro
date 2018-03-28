class DropFromProductList < ActiveRecord::Migration[5.1]
  def change
    drop_table :product_lists
    add_index :order_details,:order_id
  end
end
