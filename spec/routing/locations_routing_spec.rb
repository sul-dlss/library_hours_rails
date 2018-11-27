# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/libraries/1/locations').to route_to('locations#index', library_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/libraries/1/locations/new').to route_to('locations#new', library_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/libraries/1/locations/1').to route_to('locations#show', id: '1', library_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/libraries/1/locations/1/edit').to route_to('locations#edit', id: '1', library_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/libraries/1/locations').to route_to('locations#create', library_id: '1')
    end

    it 'routes to #update' do
      expect(put: '/libraries/1/locations/1').to route_to('locations#update', id: '1', library_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/libraries/1/locations/1').to route_to('locations#destroy', id: '1', library_id: '1')
    end

    it 'routes to #hours' do
      expect(get: '/libraries/1/locations/1/hours').to route_to('locations#hours', id: '1', library_id: '1')
    end

    it 'routes to #hours_v1' do
      expect(get: '/api/v1/library/1/location/1/hours/for/today').to route_to('locations#hours_v1',
                                                                              library_id: '1',
                                                                              id: '1',
                                                                              when: 'today')
    end
  end
end
