Rails.application.routes.draw do
  constraints(format: :json) do
    use_doorkeeper
    resources :tourists
    resources :guides
    scope :current_tourist do
      resource :current_tourist, path: "me", only: :show, controller: :current_tourist do
      end
    end
  end
end
