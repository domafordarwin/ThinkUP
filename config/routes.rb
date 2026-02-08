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

  namespace :school_admin do
    resources :members, only: [:index, :new, :create, :show, :destroy]
    resources :programs, only: [:index, :show]
  end

  namespace :parent do
    resources :children, only: [:index, :show]
  end

  namespace :diagnosis_admin do
    resources :schools
    resources :programs
    resources :reports, only: [:index, :new, :create, :show]
    resources :announcements
    resource :dashboard, only: [:show]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
