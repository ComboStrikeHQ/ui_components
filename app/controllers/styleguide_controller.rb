class StyleguideController < ApplicationController
  layout 'styleguide'

  def index
    @components = UiComponents::Styleguide.components
  end
end
