class Meal < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  def meal_favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # そのままデータを取り出すと，日付が不連続なデータになるため，日付の連続したデータを作成する。
  def self.chart_data(user)
    meals = User.find(user.id).meals.order(date: :asc)
    meals_array = meals.pluck(:calorie, :date)
    meals_array2 = meals_array.group_by &:last
    meals_array3 = meals_array2.map do |k, v|
      [(v.map &:first).sum, k]
    end
    # 記録が無い場合にエラーが出るのを防止
    return [{ date: Date.today, weight: nil }] if meals_array3.empty?

    period = meals_array3[0][1]..meals_array3[-1][1]
    # 記録の初日から最終日までの配列データを作成
    index = 0
    period.map do |date|
      if meals_array3[index][1] == date
        calorie = meals_array3[index][0]
        index += 1
      end
      # データが存在しない日付の体重は nil とする。
      { date: date, calorie: calorie }
    end
  end
end
