class ComponentsController < ApplicationController
  def show
    render params[:name], render_params
  end

  private

  def render_params
    params.permit(:layout)
  end
end
