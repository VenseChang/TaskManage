class CreateJoinTableTaskMember < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tasks, :users do |t|
      t.index [:task_id, :user_id]
    end
  end
end
