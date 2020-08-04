class AddBodyFatToWeights < ActiveRecord::Migration[5.2]
  def change
    add_column :weights, :body_fat, :float
  end
end
