class Tour < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  accepts_nested_attributes_for :answers

  property :id
  property :content
  property :tourist_id

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
