class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :status
      t.string :title
      t.text :description
      t.datetime :firm_due
      t.datetime :suggested_due
      t.integer :complexity
      t.string :urgency
      t.references :author, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.references :assignable, type: :uuid, null: true, polymorphic: true
      t.references :completed_by, type: :uuid, null: true, foreign_key: { to_table: :users }
      t.datetime :completed_at
      t.references :recurring_task_template, type: :uuid, null: true, foreign_key: true
      t.references :wave, type: :uuid, null: true, foreign_key: true

      t.timestamps
    end
  end
end
