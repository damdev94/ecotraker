class DaysController < ApplicationController
  def index
    today = Date.today
    @trips = Trip.joins(:days).where(days: {date: today}).distinct
  end
end
