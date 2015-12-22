class CurrentTourist::Plans::LocationsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def require_resources
    # なぜかbefore_actionが呼び出されない
    @plan = Plan.find(params[:plan_id])
    @resources = Location.classify_location(@plan.answers)
  end

  def create_resource
    binding.pry
  end
end
