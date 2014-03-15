IgakutenApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :mailing_list_archives, only: :create

  resources :participations,        only: %i(index create destroy)

  resources :shifts,                only: %i(index create destroy)

  resources :quorums,               only: %i(index update)

  resources :periods,               only: :index

  resources :teams,                 only: :index

  resources :sections,              only: :index

  resources :staffs,                only: :index do
    member do
      get 'verificate/:verification_code', action: :verificate, as: :verificate
    end
  end

  root to: 'admin/dashboard#index'
end
