class Location < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  attr_reader :probability

  has_many :plan_locations
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

  def self.classify_location

  end

  def self.conditional_probability
    @location = Location.first
    answers = Plan.find(30).answers
    plans = []
    @location.plans.each do |plan|
      size = 0
      plan.answers.each do |answer|
        answers.each do |_answer|
          if answer.choice_id == _answer.choice_id
            size += 1
          end
        end
      end
      if size == plan.answers.count
        plans << plan
      end
    end
    @plan_count = @location.plans.count
    probability = (plans.count.to_f / @plan_count.to_f)
    return probability
  end

  def self.probability_x
    answers = Plan.find(30).answers
    plans = []
    Plan.all.each do |plan|
      size = 0
      plan.answers.each do |answer|
        answers.each do |_answer|
          if answer.choice_id == _answer.choice_id
            size += 1
          end
        end
      end
      if size == plan.answers.count
        plans << plan
      end
    end
    probability = plans.count.to_f / Plan.all.count.to_f
    return probability

  end

  def self.probability_y
    @location = Location.first
    probability = @location.plans.count.to_f / Plan.all.count
    return probability
  end

  def self.bayes_theorem
    probability = conditional_probability * probability_y / probability_x
    return probability
  end
end
