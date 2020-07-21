class CreateWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :weights do |t|
      t.date :date, null: false
      t.float :weight, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    
    add_index :weights, [:user_id, :date], unique: true
  end
end
