class SearchController < ApplicationController
  def search
    result = [
      { value: 'foo', text: 'Fooo' },
      { value: 'bar', text: 'Baar' },
      { value: 'baz', text: 'Baaz' }
    ].select { |item| item[:text].include?(params.require(:term)) }
    render json: result
  end
end
