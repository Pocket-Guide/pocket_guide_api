class Question < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  has_many :choices

  property :id
  property :content
  collection :choices

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
