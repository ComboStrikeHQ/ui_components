class SearchController < ApplicationController
  def search
    result = [
      { value: 'foo', label: 'Fooo' },
      { value: 'bar', label: 'Baar' },
      { value: 'baz', label: 'Baaz' }
    ].select { |item| item[:label].include?(params.require(:term)) }
    render json: result
  end
end
