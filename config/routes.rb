IgakutenApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :shifts,   only: %i(index create) do
    collection do
      get 'designer'
    end
  end

  resources :periods,  only: :index

  resources :teams,    only: :index

  resources :sections, only: :index

  resources :staffs,   only: :index do
    collection do
      get 'teams'
    end
    member do
      get 'verificate/:verification_code', action: :verificate, as: :verificate
      post 'participate/:team_id', action: :participate
      post 'unparticipate/:team_id', action: :unparticipate
    end
  end

  root 'index#index'
end
