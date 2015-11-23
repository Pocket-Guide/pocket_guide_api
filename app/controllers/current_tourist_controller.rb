class CurrentTouristController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!
  before_action except: :create do
    doorkeeper_authorize! :tourist
  end

  def require_resource
    @resource = current_resource_owner
  end
end
