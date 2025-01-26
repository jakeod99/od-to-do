class CreateWaves < ActiveRecord::Migration[8.0]
  def up
    create_enum :wave_status, [ "waiting", "active", "completed" ]

    create_table :waves, id: :uuid do |t|
      t.enum :status, enum_type: :wave_status, default: "waiting", null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end

  def down
    drop_table :waves

    execute <<-SQL
      DROP TYPE wave_status;
    SQL
  end
end
