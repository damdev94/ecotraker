class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def profile
    @score = current_user.trips.sum do |trip|
      trip.score
    end
   @placement =  (@score * 100) / 40
  end


end
