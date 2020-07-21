class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickname, null: false
      t.integer :age, null: false
      t.integer :active, null: false
      t.float :height, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :profiles, :nickname, unique: true
  end
end
