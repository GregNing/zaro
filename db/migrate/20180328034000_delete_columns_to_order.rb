class DeleteColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    # remove_column :orders,:billing_name
    # remove_column :orders,:billing_address
    add_column :orders,:shipping_cellphone,:integer    
  end
end
