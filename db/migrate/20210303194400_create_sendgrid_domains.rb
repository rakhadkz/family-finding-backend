class CreateSendgridDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :sendgrid_domains do |t|
      t.references :organization, foreign_key: true
      t.integer :domain_id

      t.timestamps
    end
  end
end
