Rails.application.routes.draw do

  namespace :admin do
    root "application#index"

    resources :courses, only: [:new, :create, :destroy]
    resources :users do
      member do
        patch :archive
      end
    end
  end

  devise_for :users
  root "courses#index"
  resources :courses, only: [:index, :show, :edit, :update] do
    resources :tickets
  end
  resources :attachments, only: [:show]
end
