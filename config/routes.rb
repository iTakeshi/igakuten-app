IgakutenApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :shifts,   only: [:index]

  resources :periods,  only: [:index]

  resources :teams,    only: [:index, :show]

  resources :sections, only: [:index, :show]

  resources :staffs,   only: [:index, :show] do
    collection do
      get 'teams'
      get 'recesses'
    end
    member do
      get 'verificate/:verification_code', action: :verificate, as: :verificate
      post 'participate/:team_id', action: :participate
      post 'unparticipate/:team_id', action: :unparticipate
      post 'recess/:period_id', action: :recess
      post 'return/:period_id', action: :return
    end
  end

  root 'index#index'
end
