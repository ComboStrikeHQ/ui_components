class ComponentsController < ApplicationController
  def show
    render params[:name], layout: render_layout?
  end

  private

  def render_layout?
    params[:layout] != 'false'
  end
end
