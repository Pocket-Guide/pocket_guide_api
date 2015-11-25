class CurrentTourist::QuestionsController < ApplicationController
  include Garage::RestfulActions
  def require_resources
    @resources = Question.joins(:choice).all
  end
end
