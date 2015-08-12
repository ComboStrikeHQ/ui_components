Rails.application.routes.draw do
  mount MountainView::Engine => "/mv"
  get '/select_async_data' => 'search#search'
  get '/*name' => 'components#show'
end
