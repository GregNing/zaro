class AddColumnsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products,:s,:integer,default: 0
    add_column :products,:m,:integer,default: 0
    add_column :products,:l,:integer,default: 0
  end
end
