class CurrentGuideController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action except: :create do
    doorkeeper_authorize! :guide
  end

  def require_resource
    @resource = current_resource_owner
  end
end
