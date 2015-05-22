require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  let(:library) { create(:library) }

  before do
    stub_current_user(build(:superadmin_user))
  end

  describe 'GET /library/1/locations' do
    it 'works! (now write some real specs)' do
      get library_locations_path(library)
      expect(response).to redirect_to(library_path(library))
    end
  end
end
