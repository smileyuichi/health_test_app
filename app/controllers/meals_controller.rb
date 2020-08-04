class MealsController < ApplicationController

    def index
        @meals = Meal.all
        user = User.find(current_user.id)
        @user_weight = user.weights.find_by(date: Date.today)
        @user_profile = user.profile
    end

    def show
        # @meal = Meal.find_by(user_id: current_user.id)
    end

    def new
        @meal = Meal.new
    end
    
    def create
        Meal.create!(meal_params)
        flash[:notice] = "食事内容を作成しました"
        redirect_to user_meals_path
    end
    
    def edit
        @meal = Meal.find_by(id: params[:id], user_id: params[:user_id])
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

    def meal_params
        params.require(:meal).permit(:meal_name, :calorie, :protein, :fat, :carbo, :date).merge(user_id: current_user.id, timing: 0)
    end

    

end