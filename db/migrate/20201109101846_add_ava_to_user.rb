class AddAvaToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ava, :text
  end
end
