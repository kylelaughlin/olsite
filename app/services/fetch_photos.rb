class FetchPhotos
  def perform
    oauth_url = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['APP_ID']}&client_secret=#{ENV['APP_SECRET']}&grant_type=client_credentials"
    oauth_raw_response = HTTParty.get(oauth_url)
    oauth_response = JSON.parse(oauth_raw_response.body)

    access_token = oauth_response['access_token']

    url = "https://graph.facebook.com/me/accounts?access_token=#{access_token}"
    me_response = JSON.parse(HTTParty.get(url).body)
    
    # pages_url = "https://graph.facebook.com/#{ENV["USER_ID"]}/accounts?access_token=#{access_token}"
    #
    # pages_raw_response = HTTParty.get(pages_url)
    # pages_response = JSON.parse(pages_raw_response.body)
    # byebug
    # pages = pages_response['data']
    #
    # out_loud_page = pages.find { |page| page['name'] == 'Out Loud' }
    # access_token = out_loud_page['access_token']
    # page_id = out_loud_page['id']

    url = "https://graph.facebook.com/v4.0/118492114894836/albums?access_token=#{access_token}"

    albums_raw_response = HTTParty.get(url)
    albums_response = JSON.parse(albums_raw_response.body)

    albums = albums_response['data']
    byebug
    show_albums = albums.select { |album| album['name'].include?('Show') }

    show_albums.each do |album|
      url = "https://graph.facebook.com/v4.0/#{album['id']}/photos?access_token=#{access_token}&fields=name,source&limit=100&order=reverse_chronological"

      request_photos(url)
    end

    images
  end

  private

  def request_photos(url)
    photos_raw_response = HTTParty.get(url)
    photos_response = JSON.parse(photos_raw_response.body)
    byebug
    add_photos(photos_response['data'])

    request_photos(photos_response['paging']['next']) if photos_response['paging']['next']
  end

  def add_photos(photos)
    reversed = photos.reverse
    images << photos.map { |photo| photo['source'] }
    images.flatten!
  end

  def images
    @images ||= []
  end
end
