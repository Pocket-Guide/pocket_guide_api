Rails.application.routes.draw do
  devise_for :tourists
  constraints(format: :json) do
    resources :tourists
  end
end
