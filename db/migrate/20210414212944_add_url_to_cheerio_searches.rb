class AddUrlToCheerioSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :cheerio_searches, :url, :string
  end
end
