class CurrentTourist::Plans::RecommendationsController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :set_plan, only: :index

  def index
    @resources = Location.classify_location(@plan.answers)
    respond_to do |format|
      format.json { render json: @resources }
    end
  end

  private
  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
