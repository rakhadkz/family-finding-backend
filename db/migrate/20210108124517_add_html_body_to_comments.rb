class AddHtmlBodyToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :html_body, :text
  end
end
