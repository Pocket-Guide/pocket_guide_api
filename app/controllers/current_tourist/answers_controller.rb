class CurrentTourist::AnswersController < ApplicationController
  include Garage::RestfulActions
  skip_before_action :doorkeeper_authorize!

  private
  def answer_params
    params.permit(:tour).permit(:content, answers_attributes: [:choice, :question_id])
  end
end
