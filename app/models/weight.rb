class Weight < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :weight, presence: true
  validates :body_fat, presence: true

  def self.chart_data(user)
    weights = user.weights.order(date: :asc)
    # 記録が無い場合にエラーが出るのを防止
    return [{ date: Date.today, weight: nil, body_fat: nil }] if weights.empty?

    period = weights[0].date..weights[-1].date
    # 記録の初日から最終日までの配列データを作成
    index = 0
    period.map do |date|
      if weights[index].date == date
        weight = weights[index].weight
        body_fat = weights[index].body_fat
        index += 1
      end
      # データが存在しない日付の体重は nil とする。
      { date: date, weight: weight, body_fat: body_fat }
    end
  end
end
