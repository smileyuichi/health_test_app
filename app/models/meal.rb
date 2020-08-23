class Meal < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  def meal_favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
