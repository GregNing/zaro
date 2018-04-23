class EditColumnnameFormAddress < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses,:address,:addr
    add_column :addresses,:name,:string
  end
end
