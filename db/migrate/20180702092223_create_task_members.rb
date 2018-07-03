class CreateTaskMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_members do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
