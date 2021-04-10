class AddSchoolDistrictToChildren < ActiveRecord::Migration[6.0]
  def change
    add_reference :children, :school_district, foreign_key: true
  end
end
