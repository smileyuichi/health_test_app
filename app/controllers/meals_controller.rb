class MealsController < ApplicationController

    def index
        if params[:date].present?
            @meals = Meal.where(date: params[:date], user_id: current_user.id)
        else
            @meals = Meal.where(date: Date.today, user_id: current_user.id)
        end
        user = User.find(current_user.id)
        @user_weight = user.weights.find_by(date: Date.today)
        @user_profile = user.profile
        
    end

    def show
        # @meal = Meal.find_by(user_id: current_user.id)
    end

    def new
        @meal = Meal.new
        @favorite_meals = Favorite.where(user_id: current_user.id)
        
    end
    
    def create
        meal = Meal.new(new_meal_params)
        meal.calorie = (meal.protein + meal.carbo) * 4 + meal.fat * 9
        meal.save
        flash[:notice] = "食事内容を作成しました"
        redirect_to user_meals_path
    end
    
    def edit
        @meal = Meal.find_by(id: params[:id], user_id: params[:user_id])
        @favorite_meals = Favorite.where(user_id: current_user.id)

    end
    
    def update
        @meal = Meal.find_by(id: params[:id], user_id: params[:user_id])
        if @meal.nil?
            flash[:alert] = 'エラーが発生しました'
        elsif params[:_destroy].nil? && @meal.update(meal_params)
            flash[:notice] = "記録を修正しました。"
        elsif params[:_destroy].present? && @meal.destroy
            flash[:alert] = "記録を削除しました。"
        else
            flash[:alert] = 'エラーが発生しました'
        end
        redirect_to user_meals_path
    end

    private

    def new_meal_params
        params.require(:meal).permit(:meal_name, :protein, :fat, :carbo, :date).merge(user_id: current_user.id, timing: 0)
    end

    def meal_params
        params.require(:meal).permit(:meal_name, :calorie, :protein, :fat, :carbo, :date).merge(user_id: current_user.id, timing: 0)
    end



end