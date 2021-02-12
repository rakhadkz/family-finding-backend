class AddChildContactToTemplatesSents < ActiveRecord::Migration[6.0]
  def change
    add_reference :templates_sents, :child_contact, foreign_key: true
  end
end
