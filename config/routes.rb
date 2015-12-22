Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    resources :locations
  end
  get 'admin' => 'admin/locations#index'

  constraints(format: :json) do
    use_doorkeeper
    resources :tourists
    resources :guides

    resources :locations, only: [:index, :show]

    scope :current_tourist do
      resource :current_tourist, path: "me", only: :show, controller: :current_tourist do
        resources :questions, module: 'current_tourist'
        resources :answers, module: 'current_tourist'
        resources :plans, module: 'current_tourist'
        resources :plans, only: :show, module: 'current_tourist' do
          resources :recommendations, only: :index, module: "plans"
          resources :locations, only: :index, module: "plans"
        end
      end
    end

    scope :current_guide do
      resource :current_guide, path: "me", only: :show, controller: :current_guide do
      end
    end
  end
end
