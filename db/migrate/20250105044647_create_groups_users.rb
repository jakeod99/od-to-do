class CreateGroupsUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :groups_users do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :group, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
