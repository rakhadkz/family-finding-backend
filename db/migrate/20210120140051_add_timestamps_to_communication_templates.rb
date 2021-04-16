class AddTimestampsToCommunicationTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :communication_templates, :created_at, :datetime, null: false
    add_column :communication_templates, :updated_at, :datetime, null: false
  end
end
