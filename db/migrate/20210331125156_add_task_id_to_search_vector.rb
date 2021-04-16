class AddTaskIdToSearchVector < ActiveRecord::Migration[6.0]
  def change
    add_column :search_vectors, :task_id, :string
  end
end
