# frozen_string_literal: true
class StyleguideController < ApplicationController
  layout 'styleguide'

  def general
    @guidelines = Styleguide.guidelines
  end

  def components
    @components = Styleguide.components
  end

  def patterns
    @patterns = Styleguide.patterns
  end
end
