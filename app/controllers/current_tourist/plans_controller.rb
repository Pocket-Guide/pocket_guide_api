class CurrentTourist::PlansController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def create_resource
    @resource = current_resource_owner.tours.new(tour_params)
    @resource.save!
    @resource
  end

  private
  def tour_params
    params.permit(:content, :tourist_id)
  end

  def require_resources
  end
end
