Rails.application.routes.draw do
  constraints(format: :json) do
    use_doorkeeper
    resources :tourists
  end
end
