class CurrentTouristController < ApplicationController
  include Garage::RestfulActions
  before_action :doorkeeper_authorize!

  def require_resource
    @resource = current_resource_owner
  end
end
