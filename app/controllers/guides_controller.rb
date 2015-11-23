class GuidesController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!
  before_action except: :create do
    doorkeeper_authorize! :guide
  end

  def require_resources
    @resources = Guide.all
  end

  def require_resource
    @resource = Guide.find(params[:id])
  end

  def create_resource
    @resources.create(guide_params)
  end

  def update_resource
    @resource.update_attributes!(guide_params)
  end

  def destroy_resource
    @resource.destroy!
  end

  private
  def guide_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
