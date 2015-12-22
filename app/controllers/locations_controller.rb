class LocationsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def require_resources
    @resources = Location.all
  end

  def require_resource
    @resource = Location.find(params[:id])
  end
end
