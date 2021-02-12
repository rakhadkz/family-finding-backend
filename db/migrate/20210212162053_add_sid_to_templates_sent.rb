class AddSidToTemplatesSent < ActiveRecord::Migration[6.0]
  def change
    add_column :templates_sents, :sid, :string
  end
end
