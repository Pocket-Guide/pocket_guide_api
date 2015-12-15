class Location < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  has_many :plans, through: :plan_locations
  has_many :captured_images

  accepts_nested_attributes_for :captured_images

  enum status: [:main, :sub]

  property :id
  property :name
  property :introduction

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
