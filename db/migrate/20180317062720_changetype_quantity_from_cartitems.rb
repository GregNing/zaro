class ChangetypeQuantityFromCartitems < ActiveRecord::Migration[5.1]
  def change
    change_column :cart_items,:quantity,:integer,default: 0
  end
end
