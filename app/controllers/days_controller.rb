class DaysController < ApplicationController
  def index
    today = Date.today
    @trips = Trip.joins(:days).where(days: {date: today})
  end

  def new
    @day = Day.new
  end

  def create
    @day = Day.new(day_params)
  end

  private

  def day_params
    params.require(:day).permit(:date)
  end
end
