Rails.application.routes.draw do
  get '/:section/:slug' => 'articles#show', as: 'article', constraints: { slug: /.+-\d{8}-.+\.html/i }

  scope 'media-collection/:collection_slug' do
    get '/content/:collection_page' => 'media_collection#show'
  end

  scope module: 'staff', as: 'staff' do
    resources :articles

    resources :media

    get 'login' => 'sessions#new'

    get 'register' => 'users#new'

    scope 'forgot' do
      get 'password' => 'users#forgot_password'
    end

    controller 'sections' do
      get '/section/:section_id/organize', action: 'organize'
    end
  end

  scope 'staff.api.v1', module: 'staff' do
    mount_devise_token_auth_for 'User', at: '/auth'

    get '/articles(/:page)(/:per_page)' => 'articles#index', as: 'articles'

    resources :articles

    resources :sections

    resources :article_types

    get '/media/pending' => 'media#pending'

    resources :media

    scope 'search', module: 'search' do
      get '/writers' => 'writers#query'

      get '/articles' => 'articles#query'
    end
  end

  root 'site#index'
end
