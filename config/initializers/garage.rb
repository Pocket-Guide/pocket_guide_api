Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'acessing publicly available data' do
    access :read, Tourist
    access :write, Tourist
  end
end

Garage.configuration.strategy = Garage::Strategy::Doorkeeper

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)

  resource_owner_authenticator do
    current_tourist || redirect_to(new_tourist_session_path)
  end

  resource_owner_from_credentials do |routes|
    Tourist.authenticate(params[:email])
  end
end

Doorkeeper.configuration.token_grant_types << "password"
