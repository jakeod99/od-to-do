class CreateRecurringTaskTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :recurring_task_templates, id: :uuid do |t|
      t.string :status
      t.string :type
      t.string :days
      t.string :title
      t.text :description
      t.boolean :is_firm
      t.integer :complexity
      t.string :urgency
      t.references :author, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.references :assignable, type: :uuid, null: true, polymorphic: true

      t.timestamps
    end
  end
end
