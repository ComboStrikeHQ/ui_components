class StyleguideController < ApplicationController
  layout 'styleguide'

  def index
    @components = Styleguide.components
  end
end
