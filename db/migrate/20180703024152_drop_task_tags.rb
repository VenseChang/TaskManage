class DropTaskTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :task_tags
  end
end
