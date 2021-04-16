class CreateTemplatesSents < ActiveRecord::Migration[6.0]
  def change
    create_table :templates_sents do |t|
      t.references :communication_template, foreign_key: true
      t.references :contact, foreign_key: true
      t.references :child, foreign_key: true
      t.string :content
      t.string :opened

      t.timestamps
    end
  end
end
