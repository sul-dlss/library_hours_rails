# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Spreadsheets', type: :request do
  before do
    stub_current_user(build(:superadmin_user))
  end

  describe 'GET /spreadsheets' do
    it 'works! (now write some real specs)' do
      get spreadsheets_path
      expect(response).to have_http_status(200)
    end
  end
end
