class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end

  end

  def profile
    @score = current_user.trips.sum do |trip|
      trip.score
    end
   @placement =  (@score * 100) / 40
  end


end
