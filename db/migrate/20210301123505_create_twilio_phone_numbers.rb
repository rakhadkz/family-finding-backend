class CreateTwilioPhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :twilio_phone_numbers do |t|
      t.references :organization, foreign_key: true
      t.string :phone
      t.string :friendly_name
      t.string :phone_sid

      t.timestamps
    end
  end
end
