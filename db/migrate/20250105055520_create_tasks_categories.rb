class CreateTasksCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks_categories, id: false do |t|
      t.references :task, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
