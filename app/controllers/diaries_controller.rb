class DiariesController < ApplicationController
  def index
    gon.weight_records = Weight.chart_data(current_user)
  end

  def show
  end
end
