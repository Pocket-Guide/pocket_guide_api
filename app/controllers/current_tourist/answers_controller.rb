class CurrentTourist::AnswersController < ApplicationController
  include Garage::RestfulActions
  before_action :create, only: :set_tour
  def create_resource
    current_resource_owner.create(answer_params)
  end

  private
  def answer_params
    params.permit(:tour).permit(:content, answers_attributes: [:choice, :question_id])
  end
end
