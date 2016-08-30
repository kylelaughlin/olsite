class StaticPagesController < ApplicationController

  def home
    @future = Gig.future.order("performance_date Asc").limit(5)
  end

  def song_list
  end

  def photos
    #Create the request url to obtain the access token
    uri = URI.parse("https://graph.facebook.com/v2.7/oauth/access_token?client_id=" + ENV["APP_ID"] +
                    "&client_secret=" + ENV["APP_SECRET"] +
                    "&grant_type=client_credentials")
    response = Net::HTTP.get_response(uri)
    response = JSON.parse(response.body)
    byebug
    access_token = response["access_token"]

    page_url = "https://graph.facebook.com/v2.7/118492114894836?fields=albums%7Bname%2Cphotos%7Bimages%7D%7D&access_token=" +
                access_token
    uri = URI.parse(page_url)
    response = JSON.parse(response.body)
    @image_source = []
    response["albums"]["data"].each do |album|
      if album["name"] == "Shows: 2016" || album["name"] == "Shows: 2011 - 2015"
        album["photos"]["data"].each do |photo|
          @image_source << photo["images"][0]["source"]
        end
      end
    end
  end

  def schedule
    @future = Gig.future.order("performance_date Asc")
    @past = Gig.past.order("performance_date Desc")
  end

  def reviews
  end

end
