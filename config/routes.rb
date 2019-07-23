Rails.application.routes.draw do
  get 'comment/save'
  # get 'washer/index'
  root 'washer#index'
  get 'where_autocomplete', to: 'washer#where_autocomplete'
  get 'what_autocomplete', to: 'washer#what_autocomplete'
  get 'list', to: 'washer#list'
  get 'info/:name/:id', to: 'washer#info'
  get 'city/:state/:name', to: 'washer#city_page'
  get 'state/:state', to: 'washer#city_page'
  post 'post_comments', to: 'comment#save'
  post 'fetch_comments', to: 'comment#fetch_comments'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
