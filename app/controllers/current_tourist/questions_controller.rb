class CurrentTourist::QuestionsController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  def require_resources
    @resources = Question.all
  end
end
