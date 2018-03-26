class ChangeColumnQuantityFormProductlist < ActiveRecord::Migration[5.1]
  def change
    change_column :product_lists,:quantity,:text
  end
end
