class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.string :color
      t.string :icon, default: "regex"

      t.timestamps
    end
  end
end
