class CreateSchoolDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :school_districts do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
