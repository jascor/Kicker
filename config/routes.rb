Rails.application.routes.draw do
  get '/:section/:slug' => 'articles#show', as: 'article', constraints: { slug: /.+-(\d+)-\d{8}-.+\.html/i }

  get '/sf/:id' => 'articles#shows'

  get '/short/a/:id' => 'articles#short_redirect'

  get '/author/:author_slug(/:page)' => 'writers#show', as: 'writer'

  scope 'search', module: 'search' do
    get '/' => 'search#index'
  end

  get '/:section_slug' => 'sections#show'

  get '/:section_slug/:page' => 'sections#show_page'

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

   # get '/articles(/:page)(/:per_page)' => 'articles#index', as: 'articles'

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

  scope 'api.v1' do
    scope 'search', module: 'search' do
      get '/articles' => 'articles#query'
    end
  end

  root 'site#index'
end
