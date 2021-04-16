class AddDateApprovedToUserChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :user_children, :date_approved, :datetime
    add_column :user_children, :date_denied, :datetime
    remove_column :user_children, :approved
  end
end
