class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id,:index => true
      t.string :address
      t.string :tel
      t.timestamps
    end
  end
end
