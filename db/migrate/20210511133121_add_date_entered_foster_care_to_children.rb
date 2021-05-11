class AddDateEnteredFosterCareToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :date_entered_foster_care, :datetime
  end
end
