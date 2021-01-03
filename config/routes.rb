Rails.application.routes.draw do
  resources :projects
  resources :destinations
  resources :records

  resources :rooms do
    resources :comments
  end
  resources :users
  root to: 'pages#home' # i added this line.
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/login', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  post '/add_room/:user_id/:room_id', to: 'records#add_room', as: 'add_room'
  delete '/drop_room/:user_id/:room_id', to: 'records#drop_room', as: 'drop_room'

  #post '/add_comment:user_id/:room_id', to: 'records#add_room', as: 'add_room'
end
