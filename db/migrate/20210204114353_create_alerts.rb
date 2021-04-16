class CreateAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :alerts do |t|
      t.references :child, foreign_key: true
      t.references :contact, foreign_key: true
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
