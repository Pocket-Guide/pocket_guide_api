class Answer < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  belongs_to :choice
  belongs_to :plan
  belongs_to :question

  before_save :save_measurment

  property :id
  property :choice
  property :plan_id
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

  def save_measurment
    @measurement = Measurement.find_or_initialize_by(choice_id: choice_id)
    @measurement.answer_count += 1
    @measurement.save
  end
end
