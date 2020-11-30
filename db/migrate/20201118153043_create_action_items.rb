class CreateActionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :action_items do |t|
      t.string :title
      t.text :description
      t.integer :priority_level, default: 1
      t.string :status, default: "Open"
      t.belongs_to :user
      t.belongs_to :child

      t.timestamps
    end
  end
end
