Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: "notes#index"
  end

  resources :priorities
  resources :notes
end
