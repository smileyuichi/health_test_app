class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :meal_name
      t.integer :calorie, null: false
      t.float :protein, null: false
      t.float :fat, null: false
      t.float :carbo, null: false
      t.integer :timing, null: false
      t.date :date, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
