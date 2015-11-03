Rails.application.routes.draw do
  use_doorkeeper
  devise_for :tourists, :controllers => {
   :registrations => 'users/registrations',
   :sessions => 'users/sessions'
  }
  constraints(format: :json) do
    resources :tourists
  end
end
