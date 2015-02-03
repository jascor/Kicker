Rails.application.routes.draw do
  get '/:section/:slug' => 'articles#show', as: 'article', constraints: { slug: /.+-\d{8}-.+\.html/i }

  scope 'media-collection/:collection_slug' do
    get '/content/:collection_page' => 'media_collection#show'
  end

  scope module: 'staff', as: 'staff' do
    resources :articles

    resources :media

    controller 'sections' do
      get '/section/:section_id/organize', action: 'organize'
    end
  end

  scope 'staff.api.v1', module: 'staff' do
    resources :media

    resources :articles

    resources :sections
  end

  root 'site#index'
end
