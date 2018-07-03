class DropTaskMembers < ActiveRecord::Migration[5.2]
  def change
    drop_table :task_members
  end
end
