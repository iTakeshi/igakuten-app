IgakutenApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :teams,    only: [:index, :show]

  resources :sections, only: [:index, :show]

  resources :staffs,   only: [:index, :show] do
    collection do
      get 'teams'
    end
    member do
      get 'verificate/:verification_code', action: :verificate, as: :verificate
    end
  end

  root 'index#index'
end
