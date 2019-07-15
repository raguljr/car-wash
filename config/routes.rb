Rails.application.routes.draw do
  # get 'washer/index'
  root 'washer#index'
  get 'where_autocomplete', to: 'washer#where_autocomplete'
  get 'what_autocomplete', to: 'washer#what_autocomplete'
  get 'list', to: 'washer#list'
  get 'info/:name/:id', to: 'washer#info'
  get 'city/:name', to: 'washer#city_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
