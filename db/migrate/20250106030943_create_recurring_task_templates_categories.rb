class CreateRecurringTaskTemplatesCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :recurring_task_templates_categories, id: false do |t|
      t.references :recurring_task_template, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
