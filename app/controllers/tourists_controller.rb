class TouristsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!
  before_action except: :create do
    doorkeeper_authorize! :tourist
  end

  def require_resources
    @resources = Tourist.all
  end

  def require_resource
    @resource = Tourist.find(params[:id])
  end

  def create_resource
    @resource = @resources.create(tourist_params)
  end

  def update_resource
    @resource.update_attributes!(tourist_params)
  end

  def destroy_resource
    @resource.destroy!
  end

  private
  def tourist_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
