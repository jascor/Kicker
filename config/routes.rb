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

    resources :media

    resources :articles

    resources :sections
  end

  root 'site#index'
end
