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
  property :latitude
  property :longitude
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
      location.percentage = bayes_theorem(location, answers) * 100
      location
    end
    locations.sort!{|a, b| b.percentage <=> a.percentage }
    locations[0, 6]
  end


  def self.bayes_theorem(location, answers)
    probability = probability_location(location, answers) * probability_first_choice(location, answers) / denominator(answers)
  end

  def self.probability_location(location, answers)
    rest_answers = answers.drop(1)
    plans = []
    Plan.all.each do |plan|
      count = 0
      all_match_count = 0
      plan.answers.each do |plan_answer|
        rest_answers.each do |answer|
          if plan_answer.choice_id == answer.choice_id
            count += 1
          end
        end
      end
      if rest_answers.count == count
        plans << plan
      end
    end
    choiced_location_count = 0
    plans.each do |plan|
      if plan.locations.include?(location)
        choiced_location_count += 1
      end
    end

    if plans.count != 0
      choiced_location_count.to_f / plans.count.to_f
    else
      0.0
    end
  end



  def self.probability_first_choice(location, answers)
    rest_answers = answers.drop(1)
    plans = []
    Plan.all.each do |plan|
      count = 0
      all_match_count = 0
      plan.answers.each do |plan_answer|
        rest_answers.each do |answer|
          if plan_answer.choice_id == answer.choice_id
            count += 1
          end
        end
      end
      if rest_answers.count == count
        plans << plan
      end
    end
    choiced_location_count = 0
    plans.each do |plan|
      if plan.locations.include?(location)
        choiced_location_count += 1
      end
    end
    all_match_plans = []
    Plan.all.each do |plan|
      count = 0
      all_match_count = 0
      plan.answers.each do |plan_answer|
        answers.each do |answer|
          if plan_answer.choice_id == answer.choice_id
            all_match_count += 1
          end
        end
      end

      if answers.count == all_match_count
        all_match_plans << plan
      end
    end

    all_appropriate_condition_count = 0
    all_match_plans.each do |plan|
      if plan.locations.include?(location)
        all_appropriate_condition_count += 1
      end
    end
    if choiced_location_count != 0
      all_appropriate_condition_count.to_f / choiced_location_count.to_f
    else
      0.0
    end
  end



  def self.denominator(answers)
    rest_answers = answers.drop(1)
    plans = []
    all_match_plans = []
    Plan.all.each do |plan|
      count = 0
      all_match_count = 0
      plan.answers.each do |plan_answer|
        answers.each do |answer|
          if plan_answer.choice_id == answer.choice_id
            all_match_count += 1
          end
        end
        rest_answers.each do |answer|
          if plan_answer.choice_id == answer.choice_id
            count += 1
          end
        end
      end
      if rest_answers.count == count
        plans << plan
      end

      if answers.count == all_match_count
        all_match_plans << plan
      end
    end
    if plans.count != 0
      all_match_plans.count.to_f / plans.count.to_f
    else
      0.0
    end
  end


    def self.associate_to_plan(locations, plan)
      locations.each do |location|
        if location[:status] == 1
          @location = self.find(location[:id])
          plan.locations << @location
        end
      end
    end
end
