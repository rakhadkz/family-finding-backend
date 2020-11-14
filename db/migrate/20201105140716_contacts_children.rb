class ContactsChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts_children do |t|
      t.belongs_to :contact
      t.belongs_to :child
    end

    add_index(:contacts_children, [:contact_id, :child_id], :unique => true)
  end
end
