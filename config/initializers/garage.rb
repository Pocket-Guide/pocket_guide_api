Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'acessing publicly available data' do
    access :read, Tourist
    access :write, Tourist
    access :read, Guide
    access :write, Guide
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
    if params[:scopes] == "tourist"
      Tourist.find_by(email: params[:email])
    else
      Guide.find_by(email: params[:email])
    end
  end
end

Doorkeeper.configuration.token_grant_types << "password"
