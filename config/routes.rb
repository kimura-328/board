Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get :deleted
    end
  end
  root "sessions#new"
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
