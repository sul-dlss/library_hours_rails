require 'rails_helper'

RSpec.describe 'Calendars', type: :request do
  describe 'GET /calendars' do
    it 'works! (now write some real specs)' do
      get calendars_path
      expect(response).to have_http_status(200)
    end
  end
end
