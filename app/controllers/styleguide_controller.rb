class StyleguideController < ApplicationController
  def index
    @components = UiComponents::Styleguide.components
  end
end

