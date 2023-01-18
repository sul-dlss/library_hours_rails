# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Libraries', type: :request do
  before do
    stub_current_user(build(:superadmin_user))
  end

  describe 'GET /libraries' do
    it 'works! (now write some real specs)' do
      get libraries_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /libraries.json' do
    let!(:library) { create(:library, slug: 'green') }
    let!(:location) { create(:location, library: library, primary: true, keeps_hours: true) }

    before do
      location.calendars.create(dtstart: Time.zone.now.beginning_of_day, dtend: Time.zone.now.end_of_day, summary: 'Open')
    end

    it 'has a primary location attribute' do
      get libraries_path(format: :json)
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body).with_indifferent_access

      expect(data.dig(:data, 0, :attributes, :primary_location)).to eq("green/#{location.slug}")
    end

    it 'elevates the primary location hours to the library' do
      get libraries_path(format: :json)
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body).with_indifferent_access

      expect(data.dig(:data, 0, :attributes, :hours)).to include(hash_including(type: 'Open'))
    end

    it 'includes the library locations' do
      get libraries_path(format: :json)
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body).with_indifferent_access

      expect(data.dig(:included, 0, :id)).to eq(data.dig(:data, 0, :attributes, :primary_location))
      expect(data.dig(:included, 0, :attributes)).to include(name: location.name, primary: true)
    end
  end
end
