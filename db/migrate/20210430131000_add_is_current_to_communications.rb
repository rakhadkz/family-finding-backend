class AddIsCurrentToCommunications < ActiveRecord::Migration[6.0]
  def change
    add_column :communications, :is_current, :boolean
  end
end
