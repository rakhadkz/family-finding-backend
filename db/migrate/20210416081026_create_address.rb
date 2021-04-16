class CreateAddress < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
