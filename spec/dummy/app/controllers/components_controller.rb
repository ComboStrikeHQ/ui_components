# frozen_string_literal: true

class ComponentsController < ApplicationController
  def show
    render params[:name]
  end

  def new_show
    component_class = "#{params.require(:name)}_cell".camelize.constantize
    @example = component_class.examples[example_index]
    raise "Example #{example_index} not found" unless @example
    render layout: 'single_component'
  end

  def form_submit
    render json: params
  end

  private

  def example_index
    params.require(:example_index).to_i
  end
end
