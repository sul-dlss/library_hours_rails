require 'rails_helper'

RSpec.describe NodeMappingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/node_mappings').to route_to('node_mappings#index')
    end

    it 'routes to #new' do
      expect(get: '/node_mappings/new').to route_to('node_mappings#new')
    end

    it 'routes to #show' do
      expect(get: '/node_mappings/1').to route_to('node_mappings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/node_mappings/1/edit').to route_to('node_mappings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/node_mappings').to route_to('node_mappings#create')
    end

    it 'routes to #update' do
      expect(put: '/node_mappings/1').to route_to('node_mappings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/node_mappings/1').to route_to('node_mappings#destroy', id: '1')
    end
  end
end
