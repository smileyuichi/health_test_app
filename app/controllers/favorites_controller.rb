class FavoritesController < ApplicationController

    def create
        @meal = Meal.find(params[:meal_id])
        favorite = current_user.favorites.build(meal_id: params[:meal_id])
        favorite.save
        
    end

    def destroy
        @meal = Meal.find(params[:meal_id])
        @favorite = Favorite.find_by(meal_id: params[:meal_id], user_id: current_user.id)
        @favorite.delete
        
    end
end