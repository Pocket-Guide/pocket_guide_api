class Choice < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  belongs_to :question

  property :id
  property :content
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
