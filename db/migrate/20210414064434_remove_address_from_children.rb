class RemoveAddressFromChildren < ActiveRecord::Migration[6.0]
  def change
    remove_column :children, :address
  end
end
