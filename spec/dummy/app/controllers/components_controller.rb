class ComponentsController < ApplicationController
  def show
    render params[:name]
  end
end
