require 'rails_helper'

RSpec.describe CalendarsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/calendars').to route_to('calendars#index')
    end

    it 'routes to #new' do
      expect(get: '/calendars/new').to route_to('calendars#new')
    end

    it 'routes to #show' do
      expect(get: '/calendars/1').to route_to('calendars#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/calendars/1/edit').to route_to('calendars#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/calendars').to route_to('calendars#create')
    end

    it 'routes to #update' do
      expect(put: '/calendars/1').to route_to('calendars#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/calendars/1').to route_to('calendars#destroy', id: '1')
    end
  end
end
