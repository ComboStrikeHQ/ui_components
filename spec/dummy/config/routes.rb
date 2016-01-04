Rails.application.routes.draw do
  get '/' => 'styleguide#components', as: :styleguide_components
  get '/patterns' => 'styleguide#patterns', as: :styleguide_patterns
  get '/select_async_data' => 'search#search'
  get '/components/*name/:example_index' => 'components#new_show'
  get '/*name' => 'components#show'
  match '/form_submit' => 'components#form_submit', via: :all
end
