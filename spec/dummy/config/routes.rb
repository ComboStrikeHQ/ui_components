Rails.application.routes.draw do
  get '/*name' => 'components#show'
end
