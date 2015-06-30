Rails.application.routes.draw do
  root 'events#index'
  post 'events' => 'events#create'
end
