class CreateCommunications < ActiveRecord::Migration[6.0]
  def change
    create_table :communications do |t|
      t.string :communication_type
      t.string :value
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
