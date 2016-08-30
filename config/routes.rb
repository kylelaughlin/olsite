Rails.application.routes.draw do

  root to: 'static_pages#home', as: 'home'
  get '/song_list', to: 'static_pages#song_list', as: 'songs'
  get '/photos', to: 'static_pages#photos', as: 'photos'
  get '/schedule', to: 'static_pages#schedule', as: 'schedule'
  get '/reviews', to: 'static_pages#reviews', as: 'reviews'
  get '/contact', to: 'static_pages#contact', as: 'contact'

  post '/mail', to: 'static_pages#mail', as: 'mail'

  resources :gigs
end
