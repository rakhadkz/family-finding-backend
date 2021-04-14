class RemoveSchoolDistrictFromChildren < ActiveRecord::Migration[6.0]
  def change
    remove_column :children, :school_district
    add_reference :children, :school_district, foreign_key: true
  end
end
