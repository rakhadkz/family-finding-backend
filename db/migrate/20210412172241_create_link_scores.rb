class CreateLinkScores < ActiveRecord::Migration[6.0]
  def change
    create_table :link_scores do |t|
      t.integer :demographics
      t.integer :housing
      t.integer :financial
      t.integer :criminal_history
      t.integer :transportation

      t.timestamps
    end
  end
end
