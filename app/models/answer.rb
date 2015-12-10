class Answer < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  belongs_to :choice
  belongs_to :plan
  belongs_to :question

  property :id
  property :choice
  property :tour_plan_id
  property :choice_id
  property :question_id

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end
end
