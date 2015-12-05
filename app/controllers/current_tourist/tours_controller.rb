class CurrentTourist::ToursController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def create_resource
    @resource = Tour.create(tour_params)
  end

  private
  def tour_params
    params.permit(:content, :tourist_id)
  end
end
