class CreateOrderdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.string :product_name
      t.string :product_description
      t.string :image
      t.integer :product_price
      t.text :quantity     
      t.timestamps
    end
  end
end
