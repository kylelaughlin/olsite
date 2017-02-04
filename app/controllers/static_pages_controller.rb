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
    #Send request
    response = Net::HTTP.get_response(uri)
    response = JSON.parse(response.body)
    #isolate access_token from JSON Response
    access_token = response["access_token"]

    #Create the request url to obtain image sources
    page_url = "https://graph.facebook.com/v2.7/118492114894836?fields=albums{name,photos.limit(1000){images,created_time},created_time}&access_token=" +
                access_token
    uri = URI.parse(page_url)
    #Send request
    response = Net::HTTP.get_response(uri)
    response = JSON.parse(response.body)

    response = response["albums"]["data"].find { |a| a["name"] == "Shows: 2016 - 2017" }
    response = response["photos"]
    @image_sources = []
    loop do
      response["data"].each do |photo|
        @image_sources << photo["images"][0]["source"]
      end
      next_page = response["paging"]["next"]
      break if next_page == nil
      uri = URI.parse(next_page)
      response = Net::HTTP.get_response(uri)
      response = JSON.parse(response.body)
    end
    # #Create empty array to gather image source urls from JSON response
    # @image_sources = []
    # #Iterate through each album only accessing selected albums by name
    # response["albums"]["data"].each do |album|
    #   if album["name"] == "Shows: 2016"
    #     album["photos"]["data"].each do |photo|
    #       #populate array with strings representing the source url for each image
    #       @image_sources << photo["images"][0]["source"]
    #     end
    #   end
    # end
    @image_sources.reverse!
    @images = @image_sources.paginate(:page => params[:page], :per_page => 20)
    # @images = @image_sources.first(20)
    # current_page = params[:page] || 1
    # @images = WillPaginate::Collection.create(current_page, 20, @image_sources.length) do |pager|
    #   pager.replace @image_sources
    # end
  end

  def schedule
    @future = Gig.future.order("performance_date Asc")
    @past = Gig.past.order("performance_date Desc")
  end

  def reviews
  end

  def mail
    name = params[:name]
    email = params[:email]
    phone = params[:phone].blank? ? "Not Provided" : params[:phone]
    prefered_contact = []
    if params[:texting]
      prefered_contact << "text"
    end
    if params[:calling]
      prefered_contact << "phone call"
    end
    if params[:emailing]
      prefered_contact << "email"
    end
    if !prefered_contact.empty?
      prefered_contact = prefered_contact.join(", ")
    else
      prefered_contact = "None Listed"
    end
    inquiry = params[:inquiry]
    ContactMailer.contact_mailer(name, email, phone, prefered_contact, inquiry).deliver_now
    redirect_to home_path, notice: "Your inquiry has been sent to Out Loud. They will be in contact with you
    via email at #{email} or by phone at #{phone}.  Thank you for you interest in Out Loud!"
  end

end
