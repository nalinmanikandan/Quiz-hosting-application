Rails.application.routes.draw do
  root 'hotels#index'
  devise_for :users
  resources :hotels do
    resources :items do
      post :item_user_read_status
      resources :comments do
        resources :user_comment_votes ,only: :create
      end
			resources :ratings
    end
  end
  resources :tags
  get "items", to:"items#index"

  namespace :api do
    namespace :v1 do
      resources :hotels
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
