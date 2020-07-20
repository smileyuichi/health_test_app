class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :food_name
      t.integer :food_calorie
      t.float :food_protein
      t.float :food_fat
      t.float :food_carbo

      t.timestamps
    end
  end
end
