require 'rails_helper'

RSpec.describe 'guides', type: :request do
  include RequestHelper
  include StructureHelper

  describe 'GET /guides' do
    before do
      create_list(:guide, 3)
      get '/guides', params, env
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns guides resources' do
      expect(JSON(response.body)).to all(match(structure(:guide)))
    end
  end
end
