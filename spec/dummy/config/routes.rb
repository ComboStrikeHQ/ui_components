Rails.application.routes.draw do
  mount UiComponents::Engine, at: "/styleguide"
  get '/select_async_data' => 'search#search'
  get '/*name' => 'components#show'
end
