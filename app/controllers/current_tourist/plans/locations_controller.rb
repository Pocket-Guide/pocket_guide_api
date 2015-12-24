class CurrentTourist::Plans::LocationsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!
  before_action :set_plan

  def require_resources
    # なぜかbefore_actionが呼び出されない
    @plan = Plan.find(params[:plan_id])
    @resources = Location.where(prefecture: @plan.prefecture).classify_location(@plan.answers)
  end

  def create_resource
    @plan = Plan.find(params[:plan_id])
    @resources = Location.associate_to_plan(params[:locations], @plan)
  end

  private
  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

end
