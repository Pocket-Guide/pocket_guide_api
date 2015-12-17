Garage.configure do
  rescue_error = false
end

Garage::TokenScope.configure do
  register :public do
    access :read, Tourist
    access :write, Tourist
    access :read, Guide
    access :write, Guide
    access :read, Answer
    access :read, Plan
    access :write, Plan
  end
  register :tourist, desc: 'acessing publicly available data' do
    access :read, Plan
    access :write, Plan
    access :read, Answer
    access :write, Answer
    access :read, Tourist
    access :write, Tourist
    access :read, Question
    access :write, Question
    access :read, Location
    access :read, CapturedImage
  end
  register :guide, desc: 'acessing publicly available data' do
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
    if params[:scope] == "tourist"
      Tourist.find_by(email: params[:email])
    else
      Guide.find_by(email: params[:email])
    end
  end

  access_token_expires_in 4.hours
end

Doorkeeper.configuration.token_grant_types << "password"
