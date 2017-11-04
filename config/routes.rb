Rails.application.routes.draw do
  post '/notes/api', to: 'messages#create'
  get '/notes/api/:id', to: 'messages#show'
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root :to => redirect('/messages')
end
