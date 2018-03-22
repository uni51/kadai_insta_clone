Rails.application.routes.draw do
  root to: 'blogs#top'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :blogs do
    collection do   # idなどを必要としない固有のルーティング
      post :confirm
    end
  end

  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
