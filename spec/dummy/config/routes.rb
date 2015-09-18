Rails.application.routes.draw do
  get '/' => 'styleguide#components', as: :styleguide_components
  get '/patterns' => 'styleguide#patterns', as: :styleguide_patterns
  get '/select_async_data' => 'search#search'
  get '/*name' => 'components#show'
end
