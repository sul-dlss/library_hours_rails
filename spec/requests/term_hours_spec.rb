require 'rails_helper'

RSpec.describe 'TermHours', type: :request do
  let(:location) { create(:location) }
  let(:library) { location.library }

  before do
    stub_current_user(build(:superadmin_user))
  end

  describe 'GET /term_hours' do
    it 'works! (now write some real specs)' do
      get library_term_hours_path(library)
      expect(response).to have_http_status(200)
    end
  end
end
