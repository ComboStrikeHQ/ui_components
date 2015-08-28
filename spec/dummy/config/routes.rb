Rails.application.routes.draw do
  get '/' => 'styleguide#index'
  get '/select_async_data' => 'search#search'
  get '/*name' => 'components#show'
end
