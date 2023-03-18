Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :tasks
      resources :users
      post '/login', to: 'auth#login'
      post '/refresh', to: 'auth#refresh'
      post '/tasks/clear/:id', to: 'tasks#clear'
    end
  end
end
