class SetDefaultQuantityToCartitemns < ActiveRecord::Migration[5.1]
  def change
    change_column :cart_items,:quantity,:text,default: nil
  end
end
