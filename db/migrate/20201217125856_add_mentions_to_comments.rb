class AddMentionsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :mentions, :integer, array: true, default: []
  end
end
