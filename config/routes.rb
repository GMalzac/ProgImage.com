Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :pictures, only: [ :index, :show, :create, :destroy ] do
        member do
          get 'jpeg', to:"pictures#jpeg"
          get 'gif', to:"pictures#gif"
          get 'png', to:"pictures#png"
          get 'tiff', to:"pictures#tiff"
        end
      end
    end
  end
  root to: 'pictures#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
