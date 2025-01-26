class CreateRecurringTaskTemplates < ActiveRecord::Migration[8.0]
  def up
    create_enum :recurring_task_template_status, [ "draft", "inactive", "active", "discarded" ]

    create_table :recurring_task_templates, id: :uuid do |t|
      t.enum :status, enum_type: :recurring_task_template_status, default: "draft", null: false
      t.string :type
      t.text :days
      t.string :title
      t.text :description
      t.boolean :is_firm
      t.integer :complexity, default: 2, limit: 2
      t.integer :urgency, default: 2, limit: 2
      t.references :author, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.references :assignable, type: :uuid, null: true, polymorphic: true

      t.timestamps
    end
  end

  def down
    drop_table :recurring_task_templates

    execute <<-SQL
      DROP TYPE recurring_task_template_status;
    SQL
  end
end
