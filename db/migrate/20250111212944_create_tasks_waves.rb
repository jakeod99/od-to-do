class CreateTasksWaves < ActiveRecord::Migration[8.0]
  def up
    create_enum :tasks_waves_status, [ "planned", "rolled", "completed", "foresaken" ]

    create_table :tasks_waves do |t|
      t.references :task, type: :uuid, null: false, foreign_key: true
      t.references :wave, type: :uuid, null: false, foreign_key: true
      t.enum :status, enum_type: :tasks_waves_status, default: "planned", null: false
      t.boolean :in_initial_commitment, default: false, null: false

      t.timestamps
    end
  end

  def down
    drop_table :tasks_waves

    execute <<-SQL
      DROP TYPE tasks_waves_status;
    SQL
  end
end
