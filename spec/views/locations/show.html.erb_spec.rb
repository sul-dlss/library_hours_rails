require 'rails_helper'

RSpec.describe 'locations/show', type: :view do
  let(:library) { create(:library) }
  let(:location) { create(:location, library: library) }

  before(:each) do
    assign(:location, location)

    params[:id] = location.id
    params[:library_id] = library.id
  
    assign(:range, Calendar.week(Time.zone.now.strftime('%GW%V')))

    controller.singleton_class.class_eval do
      protected

      def current_user; end

      helper_method :current_user
    end
  end

  it 'renders new location form' do
    render
  end
end
