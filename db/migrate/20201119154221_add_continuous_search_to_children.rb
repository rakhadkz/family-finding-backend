class AddContinuousSearchToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :continuous_search, :string, default: "Yes"
  end
end
