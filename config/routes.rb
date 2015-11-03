Rails.application.routes.draw do
  use_doorkeeper
  devise_for :tourists
  constraints(format: :json) do
    resources :tourists
  end
end
