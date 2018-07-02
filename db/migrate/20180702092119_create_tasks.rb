class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.datetime :end_time
      t.integer :priority
      t.string :title
      t.text :content
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
