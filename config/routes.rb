Rails.application.routes.draw do
  devise_for :users

  namespace :developer do
    resources :passages do
      resources :base_questions, except: [:show]
    end
  end

  resources :learning_sessions, only: [:create, :show] do
    resources :responses, only: [:create]
    resources :student_questions, only: [:create]
    resources :dialogues, only: [:create]
    member do
      post :complete
    end
  end

  resource :dashboard, only: [:show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
