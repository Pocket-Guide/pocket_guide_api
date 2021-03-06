class Plan < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  has_many :answers
  has_many :plan_locations
  has_many :locations, through: :plan_locations
  belongs_to :tourist

  accepts_nested_attributes_for :answers

  property :id
  property :title
  property :tourist_id
  collection :answers
  collection :locations

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
