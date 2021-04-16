class RemoveAddressFromSchoolDistricts < ActiveRecord::Migration[6.0]
  def change
    remove_column :school_districts, :address
    remove_column :school_districts, :lat
    remove_column :school_districts, :long
  end
end
