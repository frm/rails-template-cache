Rails.application.routes.draw do

  get 'pages/index'
  root to: 'pages#index'

  mount RailsTemplateCache::Engine => "/rails_templatecache"
end
