class CurrentTourist::LocationsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def require_resources
    @locations = Location.all
  end
end
