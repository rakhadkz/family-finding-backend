class AddDateCompletedAndDateRejectedAndDateAcceptedToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_column :family_searches, :date_completed, :datetime
    add_column :family_searches, :date_rejected, :datetime
    add_column :family_searches, :date_accepted, :datetime
  end
end
