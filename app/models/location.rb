class Location < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  attr_accessor :percentage
  attr_accessor :status


  has_many :plan_locations
  has_many :plans, through: :plan_locations
  has_many :captured_images

  accepts_nested_attributes_for :captured_images

  enum status: [:main, :sub]

  property :id
  property :name
  property :introduction
  property :status
  collection :captured_images

  after_initialize do
    self.status = 0
  end

  def self.build_permissions(perms, other, target)
    perms.permits! :read
    perms.permits! :write
  end

  def build_permissions(perms, other)
    perms.permits! :read
    perms.permits! :write if self == other
  end

  def self.classify_location(answers)
    locations = Location.all.map.each do |location|
      location.percentage = bayes_theorem(location, answers)
      location
    end
    locations.sort!{|a, b| b.percentage <=> a.percentage }
  end

  def self.conditional_probability(location, answers)
    plans = []
    location.plans.each do |plan|
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
    if plans.count > 0
      @plan_count = location.plans.count
      probability = (plans.count.to_f / @plan_count.to_f)
    else
      probability = 0
    end
  end

  def self.probability_x(answers)
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
  end

  def self.probability_y(location)
    probability = location.plans.count.to_f / Plan.all.count
  end

  def self.bayes_theorem(location, answers)
    probability = conditional_probability(location, answers) * probability_y(location) / probability_x(answers)
  end

  def self.associate_to_plan(locations, plan)
    locations.each do |location|
      @location = self.find(location[:id])
      plan.locations << @location
    end
    plan.locations
  end
end
