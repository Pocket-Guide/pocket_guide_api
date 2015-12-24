class PlanLocation < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  belongs_to :plan
  belongs_to :location

  property :id
  property :plan_id
  property :location_id

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
