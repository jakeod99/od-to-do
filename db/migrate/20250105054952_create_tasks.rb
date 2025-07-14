class CreateTasks < ActiveRecord::Migration[8.0]
  def up
    create_enum :task_status, [ "draft", "unstarted", "in_progress", "completed", "failed", "skipped", "discarded" ]

    create_table :tasks, id: :uuid do |t|
      t.enum :status, enum_type: :task_status, default: "draft", null: false
      t.string :title
      t.text :description
      t.datetime :firm_due
      t.datetime :suggested_due
      t.integer :complexity, default: 2, limit: 2
      t.integer :urgency, default: 2, limit: 2
      t.references :authorable, type: :uuid, null: false, polymorphic: true
      t.references :assignable, type: :uuid, null: true, polymorphic: true
      t.references :completed_by, type: :uuid, null: true, foreign_key: { to_table: :users }
      t.datetime :completed_at

      t.timestamps
    end
  end

  def down
    drop_table :tasks

    execute <<-SQL
      DROP TYPE task_status;
    SQL
  end
end
