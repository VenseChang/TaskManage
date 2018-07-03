class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :description
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
