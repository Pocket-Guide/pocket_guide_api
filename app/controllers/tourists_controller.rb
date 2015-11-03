class TouristsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!, only: :create

  def require_resources
    @resources = Tourist.all
  end

  def require_resource
    @resource = Tourist.find(params[:id])
  end

  def create_resource
    @resources.create(tourist_params)
  end

  def update_resource
    @resource.update_attributes!(tourist_params)
  end

  def destroy_resource
    @resource.destroy!
  end

  private
  def tourist_params
    params.require(:tourist).permit(:name, :email, :password, :password_confirmation)
  end
end
