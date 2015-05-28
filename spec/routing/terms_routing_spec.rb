require 'rails_helper'

RSpec.describe TermsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/terms').to route_to('terms#index')
    end

    it 'routes to #new' do
      expect(get: '/terms/new').to route_to('terms#new')
    end

    it 'routes to #show' do
      expect(get: '/terms/1').to route_to('terms#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/terms/1/edit').to route_to('terms#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/terms').to route_to('terms#create')
    end

    it 'routes to #update' do
      expect(put: '/terms/1').to route_to('terms#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/terms/1').to route_to('terms#destroy', id: '1')
    end
  end
end
