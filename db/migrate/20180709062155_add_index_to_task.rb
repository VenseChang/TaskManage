class AddIndexToTask < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :priority
    add_index :tasks, :status
    add_index :tasks, :end_time
  end
end
