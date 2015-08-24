Rails.application.routes.draw do
  mount UiComponents::Engine, at: '/'
  get '/select_async_data' => 'search#search'
  get '/*name' => 'components#show'
end
