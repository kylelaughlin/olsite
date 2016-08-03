Rails.application.routes.draw do

  root to: 'static_pages#home', as: 'home'
  get '/song_list', to: 'static_pages#song_list', as: 'songs'
  get '/photos', to: 'static_pages#photos', as: 'photos'

end
