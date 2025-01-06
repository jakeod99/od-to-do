class CreateWaves < ActiveRecord::Migration[8.0]
  def change
    create_table :waves, id: :uuid do |t|
      t.string :status
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
