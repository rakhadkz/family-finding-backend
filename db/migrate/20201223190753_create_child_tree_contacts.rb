class CreateChildTreeContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :child_tree_contacts do |t|
      t.belongs_to :child
      t.belongs_to :contact
      t.string :relationship
      t.bigint :parent_id

      t.timestamps
    end
  end
end
