Rails.application.routes.draw do
  root 'events#index'
  get 'fetch' => 'events#fetch'
  post 'events' => 'events#create'
end
