require 'rails_helper'

RSpec.describe 'tourists', type: :request do
  include RequestHelper
  include StructureHelper

  describe 'GET /tourists' do
    before do
      create_list(:tourist, 3)
      get '/tourists', params, env
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns tourist resources' do
      expect(JSON(response.body)).to all(match(structure(:tourist)))
    end
  end
end
