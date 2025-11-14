# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TermHours', type: :request do
  let(:location) { create(:location) }
  let(:library) { location.library }
  let(:term) { create(:term) }

  before do
    stub_current_user(build(:superadmin_user))
  end

  describe 'GET /term_hours' do
    it 'works! (now write some real specs)' do
      get library_term_hours_path(library)
      expect(response).to have_http_status(200)
    end
  end

  describe 'the form for a non-persisted object' do
    it 'is successful' do
      get new_library_location_term_hour_path(library, location, term_id: term, day_of_week: 'sunday')
      expect(response).to have_http_status(200)
      expect(response.body).to include "<turbo-frame id=\"#{location.id}_#{term.id}_sunday\">"
      expect(response.body).to include 'name="term_hour[sunday]"'
    end
  end

  describe 'the form for a persisted object' do
    let(:term_hour) { create(:term_hour, term:, location:) }

    it 'is successful' do
      get edit_library_location_term_hour_path(library, location, term_hour, day_of_week: 'monday')
      expect(response).to have_http_status(200)
      expect(response.body).to include "<turbo-frame id=\"#{location.id}_#{term.id}_monday\">"
      expect(response.body).to include 'name="term_hour[monday]"'
    end
  end

  describe 'createing a new object' do
    context 'with valid params' do
      it 'creates a new TermHour' do
        expect do
          post library_location_term_hours_path(library, location, term_id: term, day_of_week: 'sunday'), params: { term_hour: { sunday: '9am-1pm' } }
        end.to change(TermHour, :count).by(1)
        expect(response).to redirect_to(library_location_term_hour_path(library, location, TermHour.last, day_of_week: 'sunday'))
      end
    end

    context 'with invalid params' do
      it 're-renders the form' do
        post library_location_term_hours_path(library, location, term_id: term, day_of_week: 'sunday'), params: { term_hour: { monday: 'who knows' } }

        expect(response).to have_http_status(200)
        expect(response.body).to include 'name="term_hour[sunday]"'
      end
    end
  end

  describe 'updating an existing object' do
    let(:term_hour) { create(:term_hour, term:, location:) }

    context 'with valid params' do
      it 'updates the requested term_hour' do
        put library_location_term_hour_path(library, location, term_hour, day_of_week: 'monday'), params: { term_hour: { monday: 'closed' } }
        expect(term_hour.reload.monday).to eq 'closed'
        expect(response).to redirect_to(library_location_term_hour_path(library, location, term_hour, day_of_week: 'monday'))
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        put library_location_term_hour_path(library, location, term_hour, day_of_week: 'monday'), params: { term_hour: { monday: 'who knows' } }
        expect(response).to have_http_status(200)
        expect(response.body).to include 'name="term_hour[monday]"'
      end
    end
  end
end
