class AddChildToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :child, foreign_key: true
  end
end
