json.extract! gig, :id, :time, :venue, :performance_date, :location, :created_at, :updated_at
json.url gig_url(gig, format: :json)