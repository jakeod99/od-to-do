class CreateCategoriesRecurringTaskTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :categories_recurring_task_templates do |t|
      t.references :recurring_task_template, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
