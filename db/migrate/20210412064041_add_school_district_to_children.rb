class AddSchoolDistrictToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :school_district, :string
    add_column :children, :address, :string
  end
end
