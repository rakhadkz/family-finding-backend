class RemoveIndexesFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :child_id
    remove_column :addresses, :contact_id
  end
end
