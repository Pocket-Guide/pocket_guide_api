class CapturedImage < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  belongs_to :location

  mount_uploader :name, CapturedImageUploader

  property :id
  property :name

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
