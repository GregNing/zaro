class UpdateCartitems < ActiveRecord::Migration[5.1]
  def change
    remove_column :cart_items,:size
    change_column :cart_items,:quantity,:text
  end
end
