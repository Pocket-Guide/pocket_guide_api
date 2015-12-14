class Location < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  has_many :plans, through: :plan_locations

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
