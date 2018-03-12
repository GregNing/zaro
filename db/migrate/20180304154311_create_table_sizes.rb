class CreateTableSizes < ActiveRecord::Migration[5.1]
  def change
    create_table :sizes do |t|
      t.integer :product_id
      t.integer :s,default: 0
      t.integer :m,default: 0
      t.integer :l,default: 0
      t.timestamps
    end
  end
end
