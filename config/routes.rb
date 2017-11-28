Rails.application.routes.draw do
  resources :blogs do
    collection do         # idなどを必要としない固有のルーティング
      post :confirm
    end
  end
end
