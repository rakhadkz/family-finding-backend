class CreateCommunicationTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_templates do |t|
      t.string :name
      t.text :content
      t.string :template_type
      t.references :organization, foreign_key: true
    end
  end
end
