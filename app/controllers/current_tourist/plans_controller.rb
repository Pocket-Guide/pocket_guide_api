class CurrentTourist::PlansController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def create_resource
    @resource = current_resource_owner.plans.new(plan_params)
    @resource.save!
    @resource
  end

  def require_resource
    @resource = Plan.find(params[:id])
  end

  private
  def plan_params
    params.permit(:title, :prefecture, answers_attributes: [:question_id, :choice_id])
  end

  def require_resources
  end
end
