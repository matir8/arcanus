Rails.application.routes.draw do
  post '/notes/api', to: 'messages#create'
  get '/notes/api/:id', to: 'messages#show'
  resources :messages
  root :to => redirect('/messages')
end
