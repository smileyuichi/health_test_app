class WeightsController < ApplicationController
  def show
    gon.weight_records = Weight.chart_data(current_user)
    gon.recorded_dates = current_user.weights.map(&:date)
    @user = User.find(current_user.id)
  end

  def create
    @weight = current_user.weights.build(weight_params)
    date = @weight.date.strftime('%Y/%-m/%-d')
    if @weight.save
      flash[:notice] = "#{date}の体重の記録を追加しました"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
  end

  def update
    @weight = current_user.weights.find_by(date: params[:weight][:date])
    date = @weight.date.strftime('%Y/%-m/%-d')
    if @weight.nil?
      flash[:alert] = 'エラーが発生しました'
    elsif params[:_destroy].nil? && @weight.update(weight_params)
      flash[:notice] = "#{date}の記録を修正しました。"
    elsif params[:_destroy].present? && @weight.destroy
      flash[:alert] = "#{date}の記録を削除しました。"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
  end

  private

  def weight_params
    params.require(:weight).permit(:date, :weight, :body_fat)
  end
end
