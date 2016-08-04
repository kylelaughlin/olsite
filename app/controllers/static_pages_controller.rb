class StaticPagesController < ApplicationController

  def home
  end

  def song_list
  end

  def photos
  end

  def schedule
    @future = Gig.future.order("performance_date Desc")
    @past = Gig.past.order("performance_date Desc")
  end

  def reviews
  end

  def contact
  end

end
