class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email_address, null: false, index: { unique: true }
      t.string :password_digest, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }
      t.string :type

      t.timestamps
    end
  end
end
