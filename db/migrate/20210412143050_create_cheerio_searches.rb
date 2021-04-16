class CreateCheerioSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :cheerio_searches do |t|
      t.integer :family_search_id
      t.string :last_task_id
      t.integer :retry_count

      t.timestamps
    end
  end
end
