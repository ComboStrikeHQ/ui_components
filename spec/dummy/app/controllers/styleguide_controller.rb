class StyleguideController < ApplicationController
  layout 'styleguide'

  def components
    @components = Styleguide.components
  end

  def patterns
    @patterns = Styleguide.patterns
  end
end
