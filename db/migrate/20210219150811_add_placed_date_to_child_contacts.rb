class AddPlacedDateToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :placed_date, :datetime, default: nil
  end
end
