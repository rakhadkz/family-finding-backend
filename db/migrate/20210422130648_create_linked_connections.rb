class CreateLinkedConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :linked_connections do |t|
      t.references :connection_1, null: false,  foreign_key: { to_table: :child_contacts }
      t.references :connection_2, null: false,  foreign_key: { to_table: :child_contacts }

      t.timestamps
    end

    add_index(:linked_connections, [:connection_1_id, :connection_2_id], :unique => true)
  end
end
