Rails.application.routes.draw do
  devise_for :tourists, :controllers => {
   :registrations => 'users/registrations',
   :sessions => 'users/sessions'
  }
  constraints(format: :json) do
    use_doorkeeper
    resources :tourists
  end
end
