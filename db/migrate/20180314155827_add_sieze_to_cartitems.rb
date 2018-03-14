class AddSiezeToCartitems < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items,:size,:string
  end
end
