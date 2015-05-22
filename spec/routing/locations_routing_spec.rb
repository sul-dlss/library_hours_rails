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
  end
end
