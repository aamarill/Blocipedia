Rails.application.routes.draw do

    resources :charges, only: [:new, :create, :destroy]

    devise_for :users

    resources :wikis

    # get 'wikis/index'
    #
    # get 'wikis/show'
    #
    # get 'wikis/new'
    #
    # get 'wikis/edit'

    # get 'welcome/index'
    # get 'welcome/about'

    get 'about' => 'welcome#about'
    root 'wikis#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
