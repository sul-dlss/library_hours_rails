require 'rails_helper'

RSpec.describe 'NodeMappings', type: :request do
  describe 'GET /node_mappings' do
    it 'works! (now write some real specs)' do
      get node_mappings_path
      expect(response).to have_http_status(200)
    end
  end
end
