# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TermHoursController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/libraries/x/term_hours').to route_to('term_hours#index', library_id: 'x')
    end

    it 'routes to #new' do
      expect(get: '/libraries/x/locations/y/term_hours/new').to route_to('term_hours#new', library_id: 'x', location_id: 'y')
    end

    it 'routes to #show' do
      expect(get: '/libraries/x/locations/y/term_hours/1').to route_to('term_hours#show', id: '1', library_id: 'x', location_id: 'y')
    end

    it 'routes to #edit' do
      expect(get: '/libraries/x/locations/y/term_hours/1/edit').to route_to('term_hours#edit', id: '1', library_id: 'x', location_id: 'y')
    end

    it 'routes to #create' do
      expect(post: '/libraries/x/locations/y/term_hours').to route_to('term_hours#create', library_id: 'x', location_id: 'y')
    end

    it 'routes to #update' do
      expect(put: '/libraries/x/locations/y/term_hours/1').to route_to('term_hours#update', id: '1', library_id: 'x', location_id: 'y')
    end

    it 'routes to #destroy' do
      expect(delete: '/libraries/x/locations/y/term_hours/1').to route_to('term_hours#destroy', id: '1', library_id: 'x', location_id: 'y')
    end
  end
end
