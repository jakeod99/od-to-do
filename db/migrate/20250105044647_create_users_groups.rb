class CreateUsersGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :users_groups, id: false do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :group, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
