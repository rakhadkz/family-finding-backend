class CreateChildContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :child_contacts do |t|
      t.belongs_to :child
      t.belongs_to :contact
      t.timestamps
    end

    add_index(:child_contacts, [:child_id, :contact_id], :unique => true)
  end
end
